# Goal

<!-- project_goal -->

# Problem statement

<!-- Why does this exist? -->
<!-- "Users can't track expenses across multiple accounts" -->

# Goals / Success Criteria
<!-- What does "done" look like? -->
<!-- "Users can link 3+ bank accounts and see unified dashboard" -->

# User Personas
<!-- Who is this for? -->
<!-- Brief description of target users -->

# Functional Requirements
<!-- What it does -->
<!-- Features, user flows, capabilities -->
<!-- Be concrete in functional requirements - "user can export data" is vague; "user can export transactions as CSV filtered by date range" is actionable -->

# Non-Functional Requirements
<!-- How well it does it -->
<!-- Performance, security, scalability, accessibility -->
<!-- Non-functional requirements often get skipped but they drive architecture decisions (e.g., "must handle 10k concurrent users" changes everything) -->

# Data Model / Entities
<!-- Core concepts -->
<!-- User, Account, Transaction, etc. -->
<!-- Data entities help AI understand the domain model, which influences database schema, API design, and UI specs -->

# Integrations / Dependencies
<!-- External systems -->
<!-- APIs, auth providers, databases -->

# Technology
<!-- The intended technology we want to use
<!-- 
    Think about: 
        - database: sqlite, postgres, mysql, etc 
	- backend framework: django, fastapi, flask
	- frontend framework: next.js (react based), nuxt (vue based), SvelteKit
	- packaging/bundling: bun (js), uv (python)
	- linting: 
        - python: ruff (linter + formatter)
	    - js/ts: biome (linter + formatter)
	- type checker: 
        - python: mypy
	    - js/ts: tsc
	- unit testing:
	    - Python: pytest, pytest-mock (mocking) Hypothesis (PBT)
	    - js/ts: bun test / vitest, fast-check (PBT)
	- e2e testing:
	    - js/ts: playwright
	- docker: docker-compose setup for development and for production
	- envvar handling: create .env.sample-t, .env is inaccessible
	- git pre_commit hooks: 
	    - linter + formatter (ruff check, ruff format, biome check), type checking (mypy, tsc), unit tests (
	- task runners: celery (worker + beat) + redis
	- caching: if needed
	- file handling: S3, local
	- i18n: if needed
	- auth: 
	    - OAuth 2.0 / OIDC:
	        - Python: Authlib, python-social-auth
	    - API keys
	    - JWT:
	        - Python: python-jose 
		- Frontend: Store JWT in memory, refresh token in httpOnly cookie (not localStorage), Short-lived access tokens (15 min), longer refresh tokens, HTTPS everywhere, CSRF protection if using cookies, Rate limit login endpoints, Implement token revocation for logout      
	    - Full auth solutions (self-hosted backend): Django Rest Knox, Django Allauth, Flask-Security, fastapi-users
	    - Full auth solutions (managed): Clerk, Auth0, Supabase Auth, Firebase Auth
	    - Frontend: managed SDK (clerk, auth0, etc), nextauth / Auth.js, oidc-client-ts
	- logging:
	    - python: structlog
	- observability & monitoring 
	    - technology:
	        - python: 
                    - metrics: prometheus-client, opentelemetry-sdk
		    - tracing: OpenTelemetry, sentry-sdk
	        - frontend:
	            - error tracking: Sentry, Bugsnag
		    - real user monitoring: PostHog, OpenReplay
	        - self-hosted stack: SigNoz
	    - log retention: 7 days, 30 days
	    - alerting: 
	        - medium: email, slack, sms
		- personnel: who gets alerted
	    - SLO/SLI: target uptime, latency p99 < 200ms
	- useful libraries:
	  - Python:
	    - python_dotenv: .env handling
--> 

# Assumptions

# Constraints
<!-- Boundaries -->
<!-- Tech stack, budget, timeline, team size, external systems and dependencies -->

# Security concerns
<!-- Security related things go here -->
<!-- 
    SAST (Static Application Security Testing), DAST (Dynamic Application Security Testing), PBT (Property-Based Testing)
    Python:
        - SAST: Bandit, Ruff
	- DAST: OWASP ZAP, Nikto
	- PBT: Hypothesis
    JS/TS:
        - SAST: ESLint + eslint-plugin-security, CodeQL
	- DAST: OWASP ZAP, Nikto
	- PBT: fast-check
-->

# Out of Scope
<!-- What it does NOT do -->
<!-- Prevents scope creep, clarifies boundaries -->
<!-- Out of Scope is underrated - explicitly stating what you're NOT building helps AI generate focused specs -->

# Development details
<!-- Ralph Wiggum Loop related stuff that would not go into any other parts (or into a PRD for that matter) -->
<!-- 
- Use .env to have access to API KEYS and other information for testing during implementation. .env otherwise is not readable by claude itself
- E2E test cases to verify that the application works as intended. This is key, to avoid reporting the application is working, while it's really not
- Determine the used technologies and check for rules that apply to that technologi in the `~/.claude/rules` directory. If there are rules, copy that directory with `mkdir -p .claude/rules && cp -r ~/.claude/rules/<rule_directory> .claude/rules`
- Create scripts in `scripts` directory that helps developers do their work. Good starter scripts:
    - `init`: Completely initializes the whole developer environment (checks .env's existence, docker setup, migraton script, other scaffolding, etc..)
    - `migrate`: Runs a migration script on the database (if it makes sense)
    - `backup`: Creates a local backup of the database and assets
    - `restore`: Restores a backup script
    - `run-tests <params>`: Runs tests. Params can be to filter for test types (all, unit, e2e, etc) and actual files or modules
    - `add-mock-data`: Creates mock data so that the application has some data to test with. These should be master data, not transactional records
- Create a task to do a "Big Sanity Test" (BST). If the application has a web based frontend, run a sanity test before finishing the implementation, so this should be done at the very end of the implementation. Do it the following way:
    - Create mock data with `add-mock-data` script, so that the application has a user to login with
    - Start all docker containers with `docker compose up -d`
    - Spawn a subagent that starts an agent-browser, passing the user credentials to it. The agent goes through the following workflow:
        1. Gets to the login page, checks:
            - Translations are visible
            - Console log for errors or warnings
        2. Logs in, checks:
            - Translations are visible
            - Console log for errors or warnings
            - Actually logged in (not on login page, rather on the designated page)
        3. After logging in, refreshes the browser ("presses" F5). Check:
            - If the login page is not loaded again
        4. Navigates to another menu. Check:
            - If the navigation works
            - Console log for errors or warnings
    - During this process, if any of the checks fail, do the following:
        1. Investigate the error:
            - Read the browser's console.log for errors
            - Spawn sonnet subagents for each docker container, and read in all the docker logs and grep for errors
            - Collect all the errors and warnings, then figure out the error
        2. Try to fix the error(s)
-->
