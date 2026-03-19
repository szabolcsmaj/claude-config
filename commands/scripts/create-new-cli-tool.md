# Create New Python CLI Tool

Scaffold a new Python CLI project with enforced standards: typed code, immutable data, ruff, pytest, pre-commit hooks, uv, .env config, PRD-first workflow.

## Variables
project_name: $1

## Instructions

### Phase 1: PRD & Clarification

1. **Use the current working directory** as the project root. The user is already inside the project directory. Do NOT create a subdirectory.

2. **Ask the user to describe what the CLI tool does** in 2-3 sentences. Then create a `prd.md` with:
   - Overview of what the tool does
   - Placeholder CLI interface section with commands (fill in after Q&A)
   - Configuration section (if .env vars are needed)
   - Error handling section (JSON output with success/error/error_code)
   - Technical details section
   - Out of scope section

3. **Ask clarifying questions** before implementation. Focus on:
   - What commands/subcommands does the CLI need?
   - What are the required vs optional flags for each command?
   - What external services or APIs does it connect to?
   - What env vars are needed? Which are required vs optional (with defaults)?
   - Edge cases: What happens when inputs are invalid? Partial failures?
   - What should the JSON output look like for each command?
   - Any business logic that needs clarification?

   Ask questions one at a time. Stop when you have enough to implement.

4. **Update `prd.md`** with all answers baked in.

### Phase 2: Project Setup

1. **Initialize with uv:**
   ```
   uv init --name <project_name>
   ```

2. **Add dependencies:**
   - `python-dotenv` as a runtime dependency
   - `pytest`, `ruff`, `pre-commit` as dev dependencies
   - Any other dependencies identified in Phase 1

3. **Configure `pyproject.toml`:**
   - `requires-python = ">=3.12"`
   - `target-version = "py312"` for ruff
   - `line-length = 120`
   - Ruff lint rules: `["E", "W", "F", "I", "N", "UP", "B", "SIM", "TCH", "ANN", "RET", "PTH"]`
   - pytest testpaths: `["tests"]`, pythonpath: `["src"]`

4. **Create `.env.example`** with all env vars documented with example values.

5. **Create `.gitignore`:**
   ```
   .venv/
   __pycache__/
   *.pyc
   .pytest_cache/
   .ruff_cache/
   .env
   *.egg-info/
   dist/
   ```

6. **Create `.pre-commit-config.yaml`:**
   - ruff format check (first)
   - ruff lint with --fix (second)
   - pytest via `uv run pytest` (third — no point running tests if linting fails)

7. **Initialize git and install pre-commit hooks:**
   ```
   git init
   uv run pre-commit install
   ```

### Phase 3: Implementation

Create the source code under `src/` with these modules:

1. **`src/types.py`** — All data types as frozen dataclasses. Include:
   - Config/account types for env var data
   - Domain types for the tool's data model
   - `*_to_dict()` functions for JSON serialization
   - Use `tuple` instead of `list` for immutable collections in dataclasses

2. **`src/config.py`** — Env var loading and validation:
   - `load_env()` to load .env from the script directory
   - Validation that all required env vars are present
   - Clear error messages listing which vars are missing
   - `ConfigError` exception with `error_code` field
   - Accept `env_vars: dict[str, str]` parameter for testability (default to `os.environ`)

3. **`src/cli.py`** — Argument parsing with argparse:
   - One frozen dataclass per subcommand (e.g., `FetchArgs`, `CreateArgs`)
   - `CommandArgs` union type of all command dataclasses
   - `build_parser()` returns `argparse.ArgumentParser`
   - `parse_args(argv: list[str] | None = None) -> CommandArgs`
   - Mutually exclusive groups where needed
   - Comma-separated values split and stripped in parse_args

4. **`src/output.py`** — JSON output helpers:
   - `output_success(data: dict) -> None` — prints JSON with `"success": true`, exits 0
   - `output_error(message: str, error_code: str) -> None` — prints JSON with `"success": false`, exits 1

5. **`<project_name>.py`** (entry point at project root):
   - Import and wire everything together
   - `main()` function with try/except routing to handlers
   - One `_handle_<command>()` function per subcommand
   - Catch domain exceptions → `output_error()`
   - Catch unexpected exceptions → `output_error()` with generic message

6. **Additional `src/` modules** as needed for the tool's domain logic (e.g., API clients, file processors). Keep modules focused and under 400 lines.

### Phase 4: Tests

Create tests under `tests/`:

1. **`tests/test_config.py`** — Test env var validation:
   - Valid config with all required vars
   - Valid config with optional vars / defaults
   - Missing each required var individually
   - Multiple missing vars reported together
   - Invalid values (wrong types, empty strings)
   - Immutability of config objects

2. **`tests/test_cli.py`** — Test argument parsing:
   - Each subcommand with minimal required args
   - Each subcommand with all options
   - Missing required flags → SystemExit
   - Mutually exclusive flags → SystemExit
   - Comma-separated values parsed correctly
   - Whitespace stripped from values
   - Unknown commands → SystemExit

3. **No mocks.** Tests should exercise real pure logic. If something needs I/O, it should accept injected dependencies (dict of env vars, list of argv, etc.).

### Phase 5: Verify & Create CLAUDE.md

1. **Run verification:**
   ```
   uv run ruff format .
   uv run ruff check .
   uv run pytest -v
   ```
   Fix any issues until all three pass clean.

2. **Create `CLAUDE.md`** — Short, no babble. Include:
   - One-line description of what the tool does
   - All commands with their flags (brief)
   - Config section pointing to `.env.example`
   - Key env vars with defaults
   - Tech stack (Python version, key deps)
   - Exit codes

3. **Final consistency check** — Verify `prd.md`, `CLAUDE.md`, and `.env.example` are consistent with each other and the implementation.

## Coding Standards (enforced throughout)

- **Types everywhere**: type hints on all function signatures and return types
- **Immutable data**: frozen dataclasses, tuples over lists in data types
- **No mutation**: create new objects, never modify in place
- **Dependency injection**: functions accept their dependencies as parameters
- **Early returns**: avoid deep nesting, max 2 levels
- **Small functions**: under 50 lines each
- **Small files**: under 400 lines each
- **Error handling**: always log with context, never leak secrets
- **Input validation**: validate at system boundaries, fail fast
- **No mocks in tests**: test pure logic with injected dependencies
- **JSON output**: all CLI output is structured JSON for AI consumption (unless user states otherwise)
- **Error format**: all errors must return `{"success": false, "error": "<error_text>", "error_code": "<ERROR_CODE>"}` — error codes are UPPER_SNAKE_CASE
- **Success format**: all success responses must include `{"success": true, ...}` with command-specific data
