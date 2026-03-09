---
paths:
  - "**/*.py"
  - "**/*.pyi"
---
# Python Security

> This file extends [common/security.md](../common/security.md) with Python specific content.

## Quick reference

1. **python-dotenv for env vars** - Always use for `.env` files (`uv add python-dotenv`)
2. **Always create .env.example** - When using env vars, create `.env.example` if missing (commit this, never commit `.env`)

## Secret Management

```python
import os
from dotenv import load_dotenv

load_dotenv()

api_key = os.environ["OPENAI_API_KEY"]  # Raises KeyError if missing
```

**.env.example** (always create if missing, commit to repo):
```bash
# Copy to .env and fill values - NEVER commit .env
DATABASE_URL=postgresql://user:pass@localhost:5432/dbname
SECRET_KEY=generate-a-secure-key
DEBUG=false
```

## Security Scanning

- Use **bandit** for static security analysis:
  ```bash
  bandit -r src/
  ```

## Reference

See skill: `django-security` for Django-specific security guidelines (if applicable).
