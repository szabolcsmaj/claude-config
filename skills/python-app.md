# Python Application Development Skill

This skill provides guidelines and conventions for Python application development.

## Activation

- **Manual**: Invoke with `/python-app` when starting a new Python project
- **Auto**: Included automatically for Python projects via rules

---

## Pre-Flight Questions

Before creating a Python application, always ask the user:

1. **Framework**: "Which web framework do you want to use? (Django recommended, FastAPI, Flask, or none for CLI/scripts)"
2. **Database**: "Does this project need a database? If yes, which one? (PostgreSQL recommended, SQLite for simple projects, none)"
3. **Project type**: "What type of project is this? (REST API, CLI tool, script, full web app)"

---

## Core Rules

### 1. Pydantic for Model Handling

Use Pydantic for all data models, configuration, and structured data.

```python
from pydantic import BaseModel, Field
from typing import Literal

class UserStatus(BaseModel):
    """Domain model for user status."""
    user_id: int = Field(..., gt=0, description="Unique user identifier")
    status: Literal["active", "inactive", "pending"] = Field(default="pending")
    email: str = Field(..., min_length=5)

class AppConfig(BaseModel):
    """Application configuration using Pydantic."""
    database_url: str
    debug: bool = False
    max_connections: int = Field(default=10, ge=1, le=100)
```

---

### 2. Validate ALL User Inputs with Pydantic

**Treat all external input as "dirty"**. Validate and sanitize before internal use.

#### REST API Input (Django example)

```python
from pydantic import BaseModel, Field, field_validator
from typing import Literal
import re

class CreateUserInput(BaseModel):
    """
    Input schema for user creation.
    All fields are validated before reaching business logic.
    """
    username: str = Field(..., min_length=3, max_length=50)
    email: str = Field(..., min_length=5, max_length=255)
    role: Literal["admin", "user", "guest"] = Field(default="user")
    age: int = Field(..., ge=13, le=120)

    @field_validator("username")
    @classmethod
    def validate_username(cls, value: str) -> str:
        if not re.match(r"^[a-zA-Z0-9_]+$", value):
            raise ValueError("Username must contain only alphanumeric characters and underscores")
        return value.lower()  # Normalize to lowercase

    @field_validator("email")
    @classmethod
    def validate_email(cls, value: str) -> str:
        if "@" not in value or "." not in value.split("@")[-1]:
            raise ValueError("Invalid email format")
        return value.lower()


# In your Django view:
from django.http import JsonResponse
from django.views import View
from pydantic import ValidationError
import json
import logging

logger = logging.getLogger(__name__)

class CreateUserView(View):
    def post(self, request) -> JsonResponse:
        try:
            raw_data = json.loads(request.body)
            # Validate and clean the input
            validated_input = CreateUserInput(**raw_data)
            # Now safe to use validated_input internally
            user = create_user(validated_input)
            return JsonResponse({"id": user.id}, status=201)
        except ValidationError as e:
            logger.warning(f"Invalid user input received. Errors: {e.errors()}")
            return JsonResponse({"errors": e.errors()}, status=400)
        except json.JSONDecodeError as e:
            logger.warning(f"Invalid JSON in request body. Error: {e}")
            return JsonResponse({"error": "Invalid JSON"}, status=400)
```

#### Form Input Validation

```python
from pydantic import BaseModel, Field, field_validator
from typing import Literal

class ContactFormInput(BaseModel):
    """Validates contact form submissions."""
    name: str = Field(..., min_length=1, max_length=100)
    email: str = Field(..., max_length=255)
    subject: Literal["support", "sales", "feedback", "other"] = Field(...)
    message: str = Field(..., min_length=10, max_length=5000)

    @field_validator("message")
    @classmethod
    def sanitize_message(cls, value: str) -> str:
        # Strip potential HTML/script injection
        import html
        return html.escape(value.strip())


# Usage in view:
def handle_contact_form(form_data: dict) -> ContactFormInput:
    """
    Validates raw form data and returns clean, typed input.
    Raises ValidationError if input is invalid.
    """
    return ContactFormInput(**form_data)
```

#### Query Parameter Validation

```python
from pydantic import BaseModel, Field
from typing import Literal

class PaginationParams(BaseModel):
    """Validates pagination query parameters."""
    page: int = Field(default=1, ge=1, le=10000)
    page_size: int = Field(default=20, ge=1, le=100)
    sort_by: Literal["created_at", "updated_at", "name"] = Field(default="created_at")
    sort_order: Literal["asc", "desc"] = Field(default="desc")


# Usage:
def list_users_view(request) -> JsonResponse:
    params = PaginationParams(
        page=request.GET.get("page", 1),
        page_size=request.GET.get("page_size", 20),
        sort_by=request.GET.get("sort_by", "created_at"),
        sort_order=request.GET.get("sort_order", "desc"),
    )
    # params is now validated and safe to use
    users = fetch_users(params)
    return JsonResponse({"users": users})
```

---

### 3. Use Ruff for Linting and Formatting

Always include ruff in the project configuration.

```toml
# pyproject.toml
[tool.ruff]
target-version = "py311"
line-length = 100

[tool.ruff.lint]
select = [
    "E",      # pycodestyle errors
    "W",      # pycodestyle warnings
    "F",      # Pyflakes
    "I",      # isort
    "B",      # flake8-bugbear
    "C4",     # flake8-comprehensions
    "UP",     # pyupgrade
    "SIM",    # flake8-simplify
]
ignore = ["E501"]  # line length handled by formatter

[tool.ruff.format]
quote-style = "double"
indent-style = "space"
```

**Commands:**
```bash
# Format code
uv run ruff format .

# Lint and fix
uv run ruff check --fix .
```

---

### 4. Use Astral UV for Dependency and Project Management

Initialize all Python projects with `uv`.

```bash
# Create new project
uv init my-project
cd my-project

# Add dependencies
uv add pydantic
uv add python-dotenv  # Always include for .env file support
uv add django
uv add pytest --dev
uv add ruff --dev
uv add pytest-cov --dev
uv add pytest-django --dev  # For Django projects

# Run commands
uv run python manage.py runserver
uv run pytest
uv run ruff check .
```

**Example pyproject.toml:**
```toml
[project]
name = "my-project"
version = "0.1.0"
description = "Project description"
readme = "README.md"
requires-python = ">=3.11"
dependencies = [
    "pydantic>=2.0",
    "python-dotenv>=1.0",
    "django>=5.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=8.0",
    "pytest-cov>=4.0",
    "pytest-django>=4.5",
    "ruff>=0.4",
]

[tool.pytest.ini_options]
DJANGO_SETTINGS_MODULE = "myproject.settings"
python_files = ["test_*.py"]
addopts = "-v --tb=short"
```

---

### 4a. Environment Variables with python-dotenv

Always use `python-dotenv` to load environment variables from `.env` files.

#### Setup and Usage

```python
# src/app/config.py
from dotenv import load_dotenv
from pydantic import BaseModel, Field
import os

# Load .env file at application startup
load_dotenv()

class AppSettings(BaseModel):
    """
    Application settings loaded from environment variables.
    Validates all env vars through Pydantic.
    """
    database_url: str = Field(default=os.getenv("DATABASE_URL", "sqlite:///db.sqlite3"))
    secret_key: str = Field(default=os.getenv("SECRET_KEY", ""))
    debug: bool = Field(default=os.getenv("DEBUG", "false").lower() == "true")
    allowed_hosts: list[str] = Field(
        default_factory=lambda: os.getenv("ALLOWED_HOSTS", "localhost").split(",")
    )
    api_key: str = Field(default=os.getenv("API_KEY", ""))

    def __init__(self, **data):
        super().__init__(**data)
        if not self.secret_key:
            raise ValueError("SECRET_KEY environment variable is required")


# Usage:
settings = AppSettings()
```

#### .env File (NEVER commit this)

```bash
# .env
DATABASE_URL=postgresql://user:pass@localhost:5432/mydb
SECRET_KEY=your-super-secret-key-here
DEBUG=true
ALLOWED_HOSTS=localhost,127.0.0.1
API_KEY=your-api-key
```

#### .env.example File (ALWAYS create and commit this)

**IMPORTANT**: When a project uses environment variables, ALWAYS create a `.env.example` file if one doesn't exist.

```bash
# .env.example
# Copy this file to .env and fill in the values
# NEVER commit .env to version control

DATABASE_URL=postgresql://user:password@localhost:5432/dbname
SECRET_KEY=generate-a-secure-key-here
DEBUG=false
ALLOWED_HOSTS=localhost
API_KEY=your-api-key-here
```

#### .gitignore Entry

Always ensure `.env` is in `.gitignore`:

```gitignore
# Environment variables
.env
.env.local
.env.*.local

# Keep .env.example tracked
!.env.example
```

#### When to Create .env.example

Create or update `.env.example` when:
1. Starting a new project that uses any environment variables
2. Adding new environment variables to an existing project
3. A `.env` file exists but `.env.example` doesn't

The `.env.example` should:
- List ALL environment variables the application needs
- Include placeholder/example values (never real secrets)
- Include comments explaining what each variable is for
- Be committed to version control

---

### 5. Never Return Null - Use Meaningful Defaults

Functions should return predictable, typed values instead of `None`.

#### Return Empty Collections Instead of None

```python
from typing import Literal

def fetch_user_tags(user_id: int, db_connection: DbConnection) -> list[str]:
    """
    Fetches tags for a user.
    Returns empty list if user has no tags or doesn't exist.
    """
    result = db_connection.query("SELECT tag FROM user_tags WHERE user_id = %s", [user_id])
    if not result:
        return []  # Not None!
    return [row["tag"] for row in result]


def get_user_preferences(user_id: int, db_connection: DbConnection) -> dict[str, str]:
    """
    Returns user preferences as a dictionary.
    Returns empty dict if no preferences set.
    """
    prefs = db_connection.get_preferences(user_id)
    if not prefs:
        return {}  # Not None!
    return prefs
```

#### Return Empty String for Missing Text

```python
def get_user_bio(user_id: int, db_connection: DbConnection) -> str:
    """
    Returns user biography.
    Returns empty string if not set.
    """
    user = db_connection.get_user(user_id)
    if not user or not user.bio:
        return ""  # Not None!
    return user.bio
```

#### Use Literal "unknown" for Missing Enum-like Values

```python
from typing import Literal

UserRole = Literal["admin", "user", "guest", "unknown"]
OrderStatus = Literal["pending", "processing", "shipped", "delivered", "unknown"]

def get_user_role(user_id: int, db_connection: DbConnection) -> UserRole:
    """
    Returns the user's role.
    Returns 'unknown' if user doesn't exist or role is not set.
    """
    user = db_connection.get_user(user_id)
    if not user or not user.role:
        return "unknown"  # Not None!
    return user.role


def get_order_status(order_id: int, db_connection: DbConnection) -> OrderStatus:
    """
    Returns current order status.
    Returns 'unknown' if order not found.
    """
    order = db_connection.get_order(order_id)
    if not order:
        return "unknown"  # Not None!
    return order.status
```

#### Use Literals for Limited String Options

```python
from typing import Literal
from pydantic import BaseModel

# Define allowed values as Literal types
LogLevel = Literal["debug", "info", "warning", "error", "critical"]
Environment = Literal["development", "staging", "production"]
HttpMethod = Literal["GET", "POST", "PUT", "PATCH", "DELETE"]

class ApiEndpoint(BaseModel):
    path: str
    method: HttpMethod
    requires_auth: bool = True


def configure_logging(level: LogLevel, environment: Environment) -> None:
    """Configure logging based on level and environment."""
    # Type checker ensures only valid values are passed
    ...


# Usage - type checker will catch invalid values:
configure_logging("info", "production")  # Valid
configure_logging("verbose", "production")  # Type error! "verbose" not in LogLevel
```

#### Optional Values - When None is Truly Needed

When `None` has semantic meaning (e.g., "not provided" vs "empty"), use explicit Optional:

```python
from typing import Optional
from pydantic import BaseModel

class UpdateUserInput(BaseModel):
    """
    For PATCH operations where None means "don't update this field"
    and empty string means "clear this field".
    """
    username: Optional[str] = None  # None = don't change, "" = not allowed by validator
    bio: Optional[str] = None       # None = don't change, "" = clear the bio


def update_user(user_id: int, updates: UpdateUserInput, db_connection: DbConnection) -> None:
    """Only updates fields that are not None."""
    if updates.username is not None:
        db_connection.update_username(user_id, updates.username)
    if updates.bio is not None:
        db_connection.update_bio(user_id, updates.bio)
```

---

### 6. Project Structure

Standard structure for Python projects:

```
my-project/
├── src/
│   └── app/
│       ├── __init__.py
│       ├── config.py         # Settings loaded from env vars via python-dotenv
│       ├── models/           # Pydantic models and Django models
│       │   ├── __init__.py
│       │   ├── domain.py     # Business/domain models (Pydantic)
│       │   └── inputs.py     # Input validation models (Pydantic)
│       ├── api/              # API views/endpoints
│       │   ├── __init__.py
│       │   └── views.py
│       └── services/         # Business logic
│           ├── __init__.py
│           └── user_service.py
├── tests/
│   ├── __init__.py
│   ├── conftest.py           # Pytest fixtures
│   ├── test_models.py
│   ├── test_api.py
│   └── test_services.py
├── .env.example              # Template for env vars (COMMIT this)
├── .gitignore                # Must include .env
├── pyproject.toml
└── README.md
```

---

### 7. Testing Conventions

Use pytest with these conventions:

```python
# tests/conftest.py
import pytest
from app.models.inputs import CreateUserInput

@pytest.fixture
def valid_user_input() -> CreateUserInput:
    """Provides a valid user input for testing."""
    return CreateUserInput(
        username="testuser",
        email="test@example.com",
        role="user",
        age=25,
    )


@pytest.fixture
def db_connection():
    """Provides a test database connection."""
    # Setup
    connection = create_test_db_connection()
    yield connection
    # Teardown
    connection.close()
```

```python
# tests/test_user_service.py
import pytest
from pydantic import ValidationError
from app.models.inputs import CreateUserInput
from app.services.user_service import create_user

class TestCreateUserInput:
    """Tests for CreateUserInput validation."""

    def test_create_user_input_valid_data_returns_model(self) -> None:
        """Valid input should create a model successfully."""
        # Arrange
        data = {
            "username": "john_doe",
            "email": "john@example.com",
            "role": "user",
            "age": 25,
        }

        # Act
        result = CreateUserInput(**data)

        # Assert
        assert result.username == "john_doe"
        assert result.email == "john@example.com"

    def test_create_user_input_invalid_email_raises_validation_error(self) -> None:
        """Invalid email should raise ValidationError."""
        # Arrange
        data = {
            "username": "john_doe",
            "email": "not-an-email",
            "role": "user",
            "age": 25,
        }

        # Act & Assert
        with pytest.raises(ValidationError) as exc_info:
            CreateUserInput(**data)

        assert "email" in str(exc_info.value)

    def test_create_user_input_invalid_role_raises_validation_error(self) -> None:
        """Invalid role (not in Literal) should raise ValidationError."""
        # Arrange
        data = {
            "username": "john_doe",
            "email": "john@example.com",
            "role": "superadmin",  # Not a valid Literal value
            "age": 25,
        }

        # Act & Assert
        with pytest.raises(ValidationError):
            CreateUserInput(**data)


class TestUserService:
    """Tests for user service functions."""

    def test_create_user_valid_input_creates_user(
        self,
        valid_user_input: CreateUserInput,
        db_connection,
    ) -> None:
        """Valid input should create a user in the database."""
        # Act
        result = create_user(valid_user_input, db_connection)

        # Assert
        assert result.id is not None
        assert result.username == valid_user_input.username
```

**Naming convention**: `test_<function>_<scenario>_<expected_outcome>`

---

### 8. Error Handling and Logging

Log errors with context, then propagate them:

```python
import logging
from typing import Literal
from pydantic import ValidationError

logger = logging.getLogger(__name__)

OrderStatus = Literal["pending", "processing", "shipped", "delivered", "unknown"]

def process_order(
    order_id: int,
    user_id: int,
    db_connection: DbConnection,
) -> OrderStatus:
    """
    Processes an order and returns its status.
    Logs errors with context and re-raises them.
    """
    try:
        order = db_connection.get_order(order_id)
        if not order:
            logger.warning(
                f"Order not found. order_id=[{order_id}], user_id=[{user_id}]"
            )
            return "unknown"

        # Process the order...
        result = external_payment_service.charge(order)
        return result.status

    except PaymentError as e:
        # Log with important context variables, then propagate
        logger.error(
            f"Payment failed for order. "
            f"order_id=[{order_id}], user_id=[{user_id}], "
            f"amount=[{order.amount}], currency=[{order.currency}]. "
            f"Error: {e}"
        )
        raise  # Propagate, don't swallow

    except DatabaseError as e:
        logger.error(
            f"Database error while processing order. "
            f"order_id=[{order_id}], user_id=[{user_id}]. "
            f"Error: {e}"
        )
        raise  # Propagate, don't swallow
```

---

### 9. Async Preference

- **Default to sync** for most Django projects
- Use async when there's clear benefit:
  - High I/O concurrency requirements
  - WebSocket implementations
  - When using FastAPI
- Always prefer sync unless the use case explicitly benefits from async

---

### 10. Python Version

- **Minimum**: Python 3.11+
- **Preferred**: Python 3.12+ for new projects
- Specified in `pyproject.toml`:

```toml
[project]
requires-python = ">=3.11"
```

---

### 11. Strict Type Hints

**Type hints are mandatory for all code.** Every function, method, variable assignment, and class attribute must have explicit type annotations.

#### Rules

1. **All function parameters must have type hints**
2. **All function return types must be annotated** (use `-> None` for functions that return nothing)
3. **All class attributes and instance variables must be typed**
4. **All module-level variables must be typed**
5. **Never use `Any`** unless absolutely necessary (e.g., when interfacing with untyped third-party libraries)

#### Avoid Generic Types

```python
# BAD - Using Any
from typing import Any

def process_data(data: Any) -> Any:
    return data

def handle_response(response: dict[str, Any]) -> Any:
    return response["result"]


# GOOD - Use specific types
from typing import TypeVar, Generic
from pydantic import BaseModel

class ApiResponse(BaseModel):
    status: str
    result: str
    error_code: int

def process_data(data: ApiResponse) -> str:
    return data.result

def handle_response(response: ApiResponse) -> str:
    return response.result
```

#### Type All Function Signatures

```python
# BAD - Missing type hints
def calculate_total(items, tax_rate):
    subtotal = sum(item.price for item in items)
    return subtotal * (1 + tax_rate)


# GOOD - Fully typed
from decimal import Decimal

def calculate_total(items: list[OrderItem], tax_rate: Decimal) -> Decimal:
    subtotal: Decimal = sum(item.price for item in items)
    return subtotal * (1 + tax_rate)
```

#### Type All Variables When Not Obvious

```python
# BAD - Ambiguous types
results = []
user_cache = {}
count = 0


# GOOD - Explicit types
results: list[ProcessingResult] = []
user_cache: dict[int, User] = {}
count: int = 0
```

#### Use TypeVar for Generic Functions

When you need generic behavior, use `TypeVar` instead of `Any`:

```python
# BAD - Using Any for generic behavior
from typing import Any

def first_element(items: list[Any]) -> Any:
    return items[0] if items else None


# GOOD - Using TypeVar
from typing import TypeVar

T = TypeVar("T")

def first_element(items: list[T]) -> T | None:
    return items[0] if items else None
```

#### When Any is Acceptable

Use `Any` **only** in these specific situations:

1. **Interfacing with untyped third-party libraries** that don't provide type stubs
2. **Dynamic JSON parsing** before validation (immediately validate with Pydantic)
3. **Decorator implementations** that must work with arbitrary signatures

```python
# Acceptable: Untyped third-party library
from typing import Any
import untyped_legacy_lib  # No type stubs available

def wrap_legacy_call(args: Any) -> Any:
    # Document why Any is needed
    return untyped_legacy_lib.process(args)


# Acceptable: Raw JSON before validation
import json
from typing import Any
from pydantic import BaseModel

class UserData(BaseModel):
    name: str
    email: str

def parse_user_json(raw_json: str) -> UserData:
    # Any is acceptable here because we immediately validate
    raw_data: Any = json.loads(raw_json)
    return UserData(**raw_data)  # Now properly typed
```

#### Enable Strict Type Checking

Configure your type checker (mypy or pyright) for strict mode:

```toml
# pyproject.toml
[tool.mypy]
python_version = "3.11"
strict = true
warn_return_any = true
warn_unused_ignores = true
disallow_untyped_defs = true
disallow_any_generics = true

[tool.pyright]
pythonVersion = "3.11"
typeCheckingMode = "strict"
reportAny = true
reportUnknownMemberType = true
```

Add type checking to your dev dependencies:

```bash
uv add mypy --dev
# or
uv add pyright --dev
```

Run type checking:

```bash
uv run mypy .
# or
uv run pyright
```
