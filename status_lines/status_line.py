#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "python-dotenv",
# ]
# ///

import json
import os
import sys
import subprocess
from pathlib import Path
from datetime import datetime

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass  # dotenv is optional


def log_status_line(input_data, status_line_output):
    """Log status line event to logs directory."""
    # Ensure logs directory exists
    log_dir = Path(".claude/data/logs")
    log_dir.mkdir(parents=True, exist_ok=True)
    log_file = log_dir / 'status_line.json'
    
    # Read existing log data or initialize empty list
    if log_file.exists():
        with open(log_file, 'r') as f:
            try:
                log_data = json.load(f)
            except (json.JSONDecodeError, ValueError):
                log_data = []
    else:
        log_data = []
    
    # Create log entry with input data and generated output
    log_entry = {
        "timestamp": datetime.now().isoformat(),
        "input_data": input_data,
        "status_line_output": status_line_output
    }
    
    # Append the log entry
    log_data.append(log_entry)
    
    # Write back to file with formatting
    with open(log_file, 'w') as f:
        json.dump(log_data, f, indent=2)


def get_git_branch():
    """Get current git branch if in a git repository."""
    try:
        result = subprocess.run(
            ['git', 'rev-parse', '--abbrev-ref', 'HEAD'],
            capture_output=True,
            text=True,
            timeout=2
        )
        if result.returncode == 0:
            return result.stdout.strip()
    except Exception:
        pass
    return None


def get_git_status():
    """Get git status indicators."""
    try:
        # Check if there are uncommitted changes
        result = subprocess.run(
            ['git', 'status', '--porcelain'],
            capture_output=True,
            text=True,
            timeout=2
        )
        if result.returncode == 0:
            changes = result.stdout.strip()
            if changes:
                lines = changes.split('\n')
                return f"±{len(lines)}"
    except Exception:
        pass
    return ""


def format_tokens(tokens: int) -> str:
    """Format token count in a human-readable way (e.g., 150k)."""
    if tokens >= 1000:
        return f"{tokens // 1000}k"
    return str(tokens)


def get_sandbox_status() -> bool | None:
    """Read sandbox status from settings file.

    Returns True if sandboxed, False if not sandboxed, None if unknown.
    """
    settings_path = Path.home() / ".claude" / "settings.local.json"

    if not settings_path.exists():
        return None

    try:
        with open(settings_path, 'r') as f:
            settings = json.load(f)

        sandbox_data = settings.get('sandbox', {})
        if isinstance(sandbox_data, dict):
            return sandbox_data.get('enabled')
        return None
    except (json.JSONDecodeError, IOError, OSError) as e:
        print(f"Error reading sandbox settings: {e}", file=sys.stderr)
        return None


def get_context_info(input_data: dict) -> tuple[int, int, int] | None:
    """Extract context window information from input data.

    Returns tuple of (used_tokens, total_tokens, used_percentage), or None if data unavailable.

    Uses the used_percentage field directly from context_window and computes
    used tokens based on that percentage and the context window size.
    """
    context_window = input_data.get('context_window', {})
    used_percentage = context_window.get('used_percentage')
    context_size = context_window.get('context_window_size')

    if used_percentage is None or context_size is None:
        return None

    # Calculate used tokens from the used percentage
    used_tokens = int((used_percentage / 100) * context_size)

    return used_tokens, context_size, int(used_percentage)


def generate_status_line(input_data: dict) -> str:
    """Generate the status line based on input data."""
    parts = []

    # Model display name
    model_info = input_data.get('model', {})
    model_name = model_info.get('display_name', 'Claude')
    parts.append(f"\033[36m[{model_name}]\033[0m")  # Cyan color

    # Context usage
    context_info_data = get_context_info(input_data)
    if context_info_data is not None:
        used_tokens, total_tokens, percent_used = context_info_data

        # Color code based on usage: green < 50%, yellow 50-80%, red > 80%
        if percent_used < 50:
            context_color = "\033[32m"  # Green
        elif percent_used < 80:
            context_color = "\033[33m"  # Yellow
        else:
            context_color = "\033[31m"  # Red

        context_info = f"{context_color}{format_tokens(used_tokens)}/{format_tokens(total_tokens)} ({percent_used}%)\033[0m"
        parts.append(context_info)

    # Current directory
    workspace = input_data.get('workspace', {})
    current_dir = workspace.get('current_dir', '')
    if current_dir:
        dir_name = os.path.basename(current_dir)
        parts.append(f"\033[34m📁 {dir_name}\033[0m")  # Blue color

    # Git branch and status
    git_branch = get_git_branch()
    if git_branch:
        git_status = get_git_status()
        git_info = f"🌿 {git_branch}"
        if git_status:
            git_info += f" {git_status}"
        parts.append(f"\033[32m{git_info}\033[0m")  # Green color

    # Version info (optional, smaller)
    version = input_data.get('version', '')
    if version:
        parts.append(f"\033[90mv{version}\033[0m")  # Gray color

    # Sandbox status (read from settings file)
    is_sandboxed = get_sandbox_status()
    if is_sandboxed is not None:
        if is_sandboxed:
            sandbox_info = "\033[32mSandbox (✓)\033[0m"  # Green with tick
        else:
            sandbox_info = "\033[31mSandbox (✗)\033[0m"  # Red with cross
        parts.append(sandbox_info)

    return " | ".join(parts)


def main():
    try:
        # Read JSON input from stdin
        input_data = json.loads(sys.stdin.read())
        
        # Generate status line
        status_line = generate_status_line(input_data)
        
        # Log the status line event (enable to inspect available fields)
        log_status_line(input_data, status_line)
        
        # Output the status line (first line of stdout becomes the status line)
        print(status_line)
        
        # Success
        sys.exit(0)
        
    except json.JSONDecodeError:
        # Handle JSON decode errors gracefully - output basic status
        print("\033[31m[Claude] 📁 Unknown\033[0m")
        sys.exit(0)
    except Exception:
        # Handle any other errors gracefully - output basic status
        print("\033[31m[Claude] 📁 Error\033[0m")
        sys.exit(0)


if __name__ == '__main__':
    main()
