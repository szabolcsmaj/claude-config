# Python Project Conventions

Include these rules automatically for all Python projects. For the full guide with examples, run `/python-app`.

## Quick Reference

1. **Pydantic for models** - All data models, configs, and structured data use Pydantic
2. **Validate ALL user inputs** - Forms, REST calls, query params are "dirty" until validated with Pydantic
3. **Ruff for linting/formatting** - Always include in project (`uv add ruff --dev`)
4. **UV for project management** - Use `uv init`, `uv add`, `uv run`
5. **python-dotenv for env vars** - Always use for `.env` files (`uv add python-dotenv`)
6. **Always create .env.example** - When using env vars, create `.env.example` if missing (commit this, never commit `.env`)
7. **Never return None** - Return `[]`, `{}`, `""`, or `"unknown"` instead
8. **Use Literals** - For limited string options, use `Literal["opt1", "opt2"]`
9. **Pytest for testing** - With pytest-django for Django projects
10. **Standard logging** - Log errors with context, then propagate (don't swallow)
11. **Prefer sync** - Unless async has clear benefit
12. **Python 3.11+** - Minimum version, prefer 3.12+ for new projects

## Before Starting a New Python Project

Always ask:
1. Which web framework? (Django recommended, FastAPI, Flask, none)
2. Does it need a database?
3. What type of project? (REST API, CLI, script, web app)

## Input Validation Pattern

```python
from pydantic import BaseModel, Field, field_validator
from typing import Literal

class UserInput(BaseModel):
    name: str = Field(..., min_length=1, max_length=100)
    role: Literal["admin", "user", "guest"] = "user"

    @field_validator("name")
    @classmethod
    def sanitize_name(cls, v: str) -> str:
        return v.strip()
```

## No-Null Return Pattern

```python
from typing import Literal

Status = Literal["active", "inactive", "unknown"]

def get_status(id: int, db: DbConnection) -> Status:
    result = db.get(id)
    if not result:
        return "unknown"  # Not None
    return result.status

def get_tags(id: int, db: DbConnection) -> list[str]:
    result = db.get_tags(id)
    return result or []  # Not None
```

## Error Handling Pattern

```python
import logging
logger = logging.getLogger(__name__)

def process(order_id: int, user_id: int, db: DbConnection) -> Result:
    try:
        return do_work(order_id, db)
    except SomeError as e:
        logger.error(
            f"Processing failed. order_id=[{order_id}], user_id=[{user_id}]. Error: {e}"
        )
        raise  # Propagate, don't swallow
```

## Environment Variables Pattern

```python
from dotenv import load_dotenv
from pydantic import BaseModel
import os

load_dotenv()

class Settings(BaseModel):
    database_url: str = os.getenv("DATABASE_URL", "sqlite:///db.sqlite3")
    secret_key: str = os.getenv("SECRET_KEY", "")
    debug: bool = os.getenv("DEBUG", "false").lower() == "true"
```

**.env.example** (always create if missing, commit to repo):
```bash
# Copy to .env and fill values - NEVER commit .env
DATABASE_URL=postgresql://user:pass@localhost:5432/dbname
SECRET_KEY=generate-a-secure-key
DEBUG=false
```
