#!/usr/bin/env bash
# run_ralph.sh - Intelligent Claude Code Looper with Exit Detection
#
# Usage: run_ralph.sh <prompt_file>
#
# This script runs Claude Code in a loop, automatically detecting when
# the project is complete using a dual-condition exit gate.

set -euo pipefail

# NOTE: All file operations use the CURRENT WORKING DIRECTORY (where you run
# the command from), not the directory where this script resides. This means:
# - IMPLEMENTATION_PLAN.md is looked up in your project directory
# - The prompt_file argument is resolved relative to your project directory

# === Configuration ===
readonly MAX_CONSECUTIVE_DONE_SIGNALS=3
readonly MAX_CONSECUTIVE_TEST_LOOPS=3
readonly TEST_PERCENTAGE_THRESHOLD=30
readonly API_LIMIT_SLEEP_SECONDS=600  # 10 minutes

# === Kimi K2 Configuration ===
set_kimi_k2_env() {
    export ANTHROPIC_BASE_URL="https://api.moonshot.ai/anthropic"
    export ANTHROPIC_MODEL="kimi-k2.5"
    export ANTHROPIC_DEFAULT_OPUS_MODEL="kimi-k2.5"
    export ANTHROPIC_DEFAULT_SONNET_MODEL="kimi-k2.5"
    export ANTHROPIC_DEFAULT_HAIKU_MODEL="kimi-k2.5"
    export CLAUDE_CODE_SUBAGENT_MODEL="kimi-k2.5"

    # Handle ANTHROPIC_AUTH_TOKEN
    if [[ -z "${ANTHROPIC_AUTH_TOKEN:-}" ]]; then
        # Try to get token from fish universal variables if fish is available
        if command -v fish &> /dev/null; then
            local fish_token
            fish_token=$(fish -c 'echo $anthropic_auth_token' 2>/dev/null || echo "")
            if [[ -n "$fish_token" && "$fish_token" != "$" ]]; then
                export ANTHROPIC_AUTH_TOKEN="$fish_token"
                log_info "Retrieved token from fish universal variables"
            fi
        fi

        # If still no token, prompt the user
        if [[ -z "${ANTHROPIC_AUTH_TOKEN:-}" ]]; then
            echo "Enter your ANTHROPIC_AUTH_TOKEN for Kimi K2:"
            read -s -r token
            export ANTHROPIC_AUTH_TOKEN="$token"
            echo "Token set for this session."
            echo "To store it permanently, add to your ~/.bashrc or ~/.zshrc:"
            echo "export ANTHROPIC_AUTH_TOKEN='your_token_here'"
            echo ""
        fi
    fi

    log_info "Using Kimi K2 model configuration"
}

# === State Variables ===
declare -i loop_count=0
declare -i consecutive_done_signals=0
declare -i consecutive_test_loops=0
declare -i total_test_loops=0
declare -i unchecked_count=0

# === Color Output ===
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# === Logging Functions ===

log_info() {
    local message="$1"
    echo -e "${BLUE}[INFO]${NC} $message"
}

log_success() {
    local message="$1"
    echo -e "${GREEN}[SUCCESS]${NC} $message"
}

log_warning() {
    local message="$1"
    echo -e "${YELLOW}[WARNING]${NC} $message"
}

log_error() {
    local message="$1"
    echo -e "${RED}[ERROR]${NC} $message" >&2
}

# === Validation Functions ===

validate_prompt_file() {
    local prompt_file="$1"

    if [[ -z "$prompt_file" ]]; then
        log_error "No prompt file specified. Usage: run_ralph.sh <prompt_file>"
        return 1
    fi

    if [[ ! -f "$prompt_file" ]]; then
        log_error "Prompt file not found: $prompt_file"
        return 1
    fi

    if [[ ! -r "$prompt_file" ]]; then
        log_error "Prompt file is not readable: $prompt_file"
        return 1
    fi

    return 0
}

validate_claude_cli() {
    if ! command -v claude &> /dev/null; then
        log_error "Claude CLI not found. Please install claude-code first."
        return 1
    fi
    return 0
}

# === Parsing Functions ===

# Extract text content from JSON stream output
# Parameters: response (string) - raw JSON stream from Claude
# Returns: extracted text content
extract_text_from_json_stream() {
    local response="$1"

    # Extract content from assistant messages in JSON stream
    # The stream format has lines like: {"type":"assistant","message":{"content":[{"text":"..."}]}}
    # Also handle content_block_delta with text deltas
    echo "$response" | grep -oP '"text"\s*:\s*"\K[^"]*' | tr -d '\n' || echo ""
}

# Parse RALPH_STATUS block from response
# Parameters: response (string) - Claude's response text
# Returns: "completion_indicators exit_signal" or "0 false" if not found
parse_ralph_status() {
    local response="$1"
    local text_content
    text_content=$(extract_text_from_json_stream "$response")

    # Look for RALPH_STATUS block in the response
    # Format: RALPH_STATUS:
    #           completion_indicators: <number>
    #           EXIT_SIGNAL: <true|false>

    local completion_indicators=0
    local exit_signal="false"

    # Extract completion_indicators
    if echo "$text_content" | grep -qiP 'completion_indicators\s*:\s*\d+'; then
        completion_indicators=$(echo "$text_content" | grep -oP 'completion_indicators\s*:\s*\K\d+' | head -1)
    fi

    # Extract EXIT_SIGNAL
    if echo "$text_content" | grep -qiP 'EXIT_SIGNAL\s*:\s*true'; then
        exit_signal="true"
    fi

    echo "$completion_indicators $exit_signal"
}

# Detect completion indicators from natural language patterns
# Parameters: response (string) - Claude's response text
# Returns: count of detected completion indicators
detect_completion_indicators() {
    local response="$1"
    local text_content
    text_content=$(extract_text_from_json_stream "$response")

    local -i count=0

    # Completion patterns to detect (case-insensitive)
    local -a patterns=(
        "all tasks complete"
        "all tasks are complete"
        "project complete"
        "project is complete"
        "implementation complete"
        "implementation is complete"
        "feature complete"
        "feature is complete"
        "phase complete"
        "ready for review"
        "ready for deployment"
        "no more tasks"
        "no remaining tasks"
        "everything is done"
        "all done"
        "project ready"
        "implementation finished"
        "work is complete"
        "successfully completed all"
    )

    for pattern in "${patterns[@]}"; do
        if echo "$text_content" | grep -qi "$pattern"; then
            ((count++))
        fi
    done

    echo "$count"
}

# Detect if the loop was primarily test-focused
# Parameters: response (string) - Claude's response text
# Returns: 0 (true) if test-focused, 1 (false) otherwise
is_test_focused_loop() {
    local response="$1"
    local text_content
    text_content=$(extract_text_from_json_stream "$response")

    # Test-related patterns
    local -a test_patterns=(
        "running tests"
        "test passed"
        "test failed"
        "all tests pass"
        "fixing test"
        "test coverage"
        "npm test"
        "pytest"
        "jest"
        "running the test"
        "test suite"
        "unit test"
        "integration test"
    )

    # Development patterns (indicates not just testing)
    local -a dev_patterns=(
        "implementing"
        "creating"
        "adding feature"
        "writing code"
        "refactoring"
        "building"
        "designing"
        "new function"
        "new component"
    )

    local -i test_count=0
    local -i dev_count=0

    for pattern in "${test_patterns[@]}"; do
        if echo "$text_content" | grep -qi "$pattern"; then
            ((test_count++))
        fi
    done

    for pattern in "${dev_patterns[@]}"; do
        if echo "$text_content" | grep -qi "$pattern"; then
            ((dev_count++))
        fi
    done

    # Consider test-focused if test patterns dominate
    if [[ $test_count -gt 0 && $test_count -gt $dev_count ]]; then
        return 0
    fi

    return 1
}

# Detect API rate limit error in response
# Parameters: response (string) - Claude's response
# Returns: 0 (true) if rate limited, 1 (false) otherwise
#
# IMPORTANT: This function only checks for ACTUAL API errors in JSON structure,
# not conversational mentions of "rate limit" in Claude's text output.
# Previous versions caused false positives when Claude discussed rate limiting.
detect_api_limit_error() {
    local response="$1"

    # Check for simple rate_limit error (most common from Claude CLI)
    # Format: {"error":"rate_limit",...}
    if echo "$response" | grep -qP '"error"\s*:\s*"rate_limit"'; then
        return 0
    fi

    # Check for Anthropic API error structure with rate limit type
    # Format: {"type":"error","error":{"type":"rate_limit_error",...}}
    if echo "$response" | grep -qP '"type"\s*:\s*"error".*"type"\s*:\s*"rate_limit_error"'; then
        return 0
    fi

    # Check for error with rate limit message in error object
    if echo "$response" | grep -qP '"type"\s*:\s*"error".*"message"\s*:\s*"[^"]*rate[_ ]?limit'; then
        return 0
    fi

    # Check for HTTP 429 status in error context (not in text content)
    if echo "$response" | grep -qP '"type"\s*:\s*"error".*"status"\s*:\s*429'; then
        return 0
    fi

    # Check for overloaded_error (Anthropic's overload response)
    if echo "$response" | grep -qP '"type"\s*:\s*"error".*"type"\s*:\s*"overloaded_error"'; then
        return 0
    fi

    # Check for resource_exhausted in error context
    if echo "$response" | grep -qP '"type"\s*:\s*"error".*"resource_exhausted"'; then
        return 0
    fi

    # Check for Claude CLI specific rate limit output (not in assistant text)
    # The CLI outputs specific error lines, not embedded in content blocks
    if echo "$response" | grep -qP '^Error:.*rate[_ ]?limit' 2>/dev/null; then
        return 0
    fi

    return 1
}

# Detect if Claude response indicates an error (not rate limit)
# Parameters: response (string) - Claude's response
# Returns: 0 (true) if error detected, 1 (false) otherwise
detect_error_response() {
    local response="$1"

    # Skip if it's a rate limit (handled separately)
    if detect_api_limit_error "$response"; then
        return 1
    fi

    # Check for error patterns in the JSON response
    if echo "$response" | grep -qP '"type"\s*:\s*"error"'; then
        return 0
    fi

    return 1
}

# === Implementation Plan Tracking ===

# Count unchecked tasks in IMPLEMENTATION_PLAN.md
# Counts lines matching "- [ ]" (standard unchecked checkbox)
# Does NOT count special markers: [O], [M], [U], [D]
# Returns: count of unchecked tasks
count_unchecked_tasks() {
    local plan_file="IMPLEMENTATION_PLAN.md"

    if [[ ! -f "$plan_file" ]]; then
        log_warning "IMPLEMENTATION_PLAN.md not found"
        echo "0"
        return
    fi

    # Count lines with "- [ ]" (unchecked) but exclude special markers [O], [M], [U], [D]
    # Pattern: "- [ ]" matches standard unchecked checkbox
    local count
    # Note: grep -c outputs "0" with exit code 1 when no matches found,
    # so we capture it directly and default to 0 only if output is empty
    count=$(grep -cE '^\s*-\s*\[ \]' "$plan_file" 2>/dev/null)
    count=${count:-0}

    # Subtract 1 to exclude the legend explanation at the top of the file
    if [[ $count -gt 0 ]]; then
        count=$((count - 1))
    fi

    echo "$count"
}

# === Main Loop Logic ===

run_claude_loop() {
    local prompt_file="$1"

    log_info "Starting Ralph loop with prompt file: $prompt_file"
    log_info "Configuration:"
    log_info "  MAX_CONSECUTIVE_DONE_SIGNALS: $MAX_CONSECUTIVE_DONE_SIGNALS"
    log_info "  MAX_CONSECUTIVE_TEST_LOOPS: $MAX_CONSECUTIVE_TEST_LOOPS"
    log_info "  TEST_PERCENTAGE_THRESHOLD: $TEST_PERCENTAGE_THRESHOLD%"
    log_info "  API_LIMIT_SLEEP_SECONDS: $API_LIMIT_SLEEP_SECONDS"
    echo ""

    while true; do
        ((++loop_count))
        log_info "=== Loop $loop_count ==="

        # Run Claude and capture response
        local response
        local exit_code=0

        response=$(cat "$prompt_file" | claude --dangerously-skip-permissions -p --output-format=stream-json --model opus --verbose 2>&1) || exit_code=$?

        # Check for API limit - sleep and retry if hit
        if detect_api_limit_error "$response"; then
            log_warning "Claude API usage limit reached. Sleeping for 10 minutes..."
            sleep $API_LIMIT_SLEEP_SECONDS
            log_info "Resuming after sleep..."
            continue
        fi

        # Check for other errors
        if detect_error_response "$response"; then
            log_error "Claude returned an error response. Check the output above."
            log_info "Continuing to next iteration..."
            continue
        fi

        # Parse RALPH_STATUS block
        local status_output
        status_output=$(parse_ralph_status "$response")
        local ralph_completion_indicators
        local exit_signal
        ralph_completion_indicators=$(echo "$status_output" | cut -d' ' -f1)
        exit_signal=$(echo "$status_output" | cut -d' ' -f2)

        # Detect heuristic completion indicators
        local heuristic_indicators
        heuristic_indicators=$(detect_completion_indicators "$response")

        # Total indicators (RALPH_STATUS + heuristic)
        local -i total_indicators=$((ralph_completion_indicators + heuristic_indicators))

        # Count unchecked tasks in IMPLEMENTATION_PLAN.md
        unchecked_count=$(count_unchecked_tasks)

        log_info "Status: completion_indicators=$total_indicators (ralph=$ralph_completion_indicators, heuristic=$heuristic_indicators), EXIT_SIGNAL=$exit_signal, unchecked_count=$unchecked_count"

        # Track test-focused loops
        if is_test_focused_loop "$response"; then
            ((++consecutive_test_loops))
            ((++total_test_loops))
            log_info "Test-focused loop detected (consecutive: $consecutive_test_loops)"
        else
            consecutive_test_loops=0
        fi

        # Track consecutive done signals
        if [[ "$exit_signal" == "true" ]]; then
            ((++consecutive_done_signals))
            log_info "Done signal received (consecutive: $consecutive_done_signals)"
        else
            consecutive_done_signals=0
        fi

        # === Exit Condition Checks ===
        # All exit conditions now require unchecked_count == 0

        # 1. Dual-condition gate (primary exit condition)
        if [[ $total_indicators -ge 2 && "$exit_signal" == "true" && $unchecked_count -eq 0 ]]; then
            log_success "EXIT: project_complete (dual-condition met: indicators=$total_indicators >= 2, EXIT_SIGNAL=true, unchecked_count=0)"
            return 0
        fi

        # 2. Multiple consecutive done signals
        if [[ $consecutive_done_signals -ge $MAX_CONSECUTIVE_DONE_SIGNALS && $unchecked_count -eq 0 ]]; then
            log_success "EXIT: $MAX_CONSECUTIVE_DONE_SIGNALS consecutive done signals received (unchecked_count=0)"
            return 0
        fi

        # 3. Too many consecutive test-focused loops
        if [[ $consecutive_test_loops -ge $MAX_CONSECUTIVE_TEST_LOOPS && $unchecked_count -eq 0 ]]; then
            log_success "EXIT: $MAX_CONSECUTIVE_TEST_LOOPS consecutive test loops (unchecked_count=0)"
            return 0
        fi

        # Log why we didn't exit if conditions were close
        if [[ $unchecked_count -gt 0 ]]; then
            if [[ $total_indicators -ge 2 && "$exit_signal" == "true" ]] || \
               [[ $consecutive_done_signals -ge $MAX_CONSECUTIVE_DONE_SIGNALS ]] || \
               [[ $consecutive_test_loops -ge $MAX_CONSECUTIVE_TEST_LOOPS ]]; then
                log_warning "Exit conditions met but $unchecked_count unchecked task(s) remain in IMPLEMENTATION_PLAN.md"
            fi
        fi

        # 4. Test percentage threshold warning
        if [[ $loop_count -gt 5 ]]; then
            local -i test_percentage=$((total_test_loops * 100 / loop_count))
            if [[ $test_percentage -gt $TEST_PERCENTAGE_THRESHOLD ]]; then
                log_warning "Test-focused sessions at ${test_percentage}% (threshold: ${TEST_PERCENTAGE_THRESHOLD}%)"
            fi
        fi

        # Continue to next iteration
        log_info "Loop $loop_count complete. Continuing..."
        echo ""
    done
}

# === Main Entry Point ===

main() {
    local use_kimi_k2=false
    local prompt_file=""

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --k2)
                use_kimi_k2=true
                shift
                ;;
            --help|-h)
                echo "Usage: run_ralph.sh [--k2] <prompt_file>"
                echo ""
                echo "Options:"
                echo "  --k2    Use Kimi K2 model configuration"
                echo "  --help  Show this help message"
                exit 0
                ;;
            *)
                if [[ -z "$prompt_file" ]]; then
                    prompt_file="$1"
                    shift
                else
                    log_error "Unexpected argument: $1"
                    exit 1
                fi
                ;;
        esac
    done

    if [[ -z "$prompt_file" ]]; then
        log_error "Usage: run_ralph.sh [--k2] <prompt_file>"
        exit 1
    fi

    # Set Kimi K2 environment if requested
    if [[ "$use_kimi_k2" == "true" ]]; then
        set_kimi_k2_env
    fi

    # Validate inputs
    if ! validate_prompt_file "$prompt_file"; then
        exit 1
    fi

    if ! validate_claude_cli; then
        exit 1
    fi

    # Run the main loop
    run_claude_loop "$prompt_file"

    log_success "Ralph loop completed successfully!"
}

main "$@"
