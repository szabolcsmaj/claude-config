# 1. Initialize project directory for Wigguming

This command will create a prd.md, prompt_plan.md, prompt_build.md, and CLAUDE.md in the directory root. This can be filled out so that the Wigguming can continue with the next command: 2-audit-create.md

## Variables

project_goal=$1

## Instructions

### 1. Create prd.md

1. If prd.md doesnt exist, create it with `cp ~/.claude/commands/ralph/templates/prd-template.md prd.md`
2. If it's not empty, ask the user if he wants to add the missing parts to the document from `~/.claude/commands/ralph/templates/prd-template.md`?
3. If he answers yes, add the missing parts from the template

### 2. Create prompt_plan.md

1. Check if prompt_plan.md exists in the directory.
2. If yes, skip this step
3. If no, create the 'prompt_plan.md' template

**prompt_plan.md template**
```md
# Rules to follow

1. Study `specs/*` with up to 250 parallel Sonnet subagents to learn the application specifications.
2. Study IMPLEMENTATION_PLAN.md (if present; it may be incorrect) and use up to 500 Sonnet subagents to study existing source code in `src/*` and compare it against `specs/*`. Use an Opus subagent to analyze findings, prioritize tasks, and create/update IMPLEMENTATION_PLAN.md as a bullet point list sorted in priority of items yet to be implemented. If an item has a sub-item, also make that as a checkbox so that it can be checked during implementation. Ultrathink. Consider searching for TODO, minimal implementations, placeholders, skipped/flaky tests, and inconsistent patterns. Study IMPLEMENTATION_PLAN.md to determine starting point for research and keep it up to date with items considered complete/incomplete using subagents.
3. IMPORTANT: Plan only. Do NOT implement anything. Do NOT assume functionality is missing; confirm with code search first. Prefer consolidated, idiomatic implementations there over ad-hoc copies. DO NOT ask for user feedback.
4. ULTIMATE GOAL: We want to create a <project_goal>. Consider missing elements and plan accordingly. If an element is missing, search first to confirm it doesn't exist, then if needed author the specification at specs/FILENAME.md. If you create a new element then document the plan to implement it in IMPLEMENTATION_PLAN.md using a subagent.
5. Make a commit after every change. Don't push.
6. Output the parts in <output_requirements>

<output_requirements>
   
At the END of every response, you MUST output a RALPH_STATUS block in this exact format:

\`\`\`
RALPH_STATUS:
  completion_indicators: <number>
  EXIT_SIGNAL: <true|false>
\`\`\`
                  
Where:  
- `completion_indicators`: Count how many of these apply to your current state:
  - A major phase/feature is complete
  - All requested tasks are done
  - The project is ready for review/deployment
  - No more pending work items
  - Tests are passing and implementation is stable

- `EXIT_SIGNAL`: Set to `true` ONLY when ALL of these are true:
  - All tasks from the plan are complete
  - No known bugs or issues remain
  - The project meets all requirements
  - You have nothing more to implement or fix
  Otherwise, set to `false`

**Examples**

If you just finished one feature but have more to do:
```
RALPH_STATUS:
  completion_indicators: 1
  EXIT_SIGNAL: false
```

If all work is done and project is ready:
```
RALPH_STATUS:
  completion_indicators: 4
  EXIT_SIGNAL: true
```

This block is REQUIRED for every response. The automation system depends on it.
</output_requirements>
```


### 3. Create prompt_build.md

1. Check if prompt_build.md exists in the directory.
2. If yes, skip this step
3. If no, create the 'prompt_build.md' template

**prompt_build.md template**
```md
0a. Study `specs/*` with up to 500 parallel Sonnet subagents to learn the application specifications.
0b. Study IMPLEMENTATION_PLAN.md.
0c. For reference, the application source code is in `src/*`.

1. Your task is to implement functionality per the specifications using parallel sonnet subagents. Follow IMPLEMENTATION_PLAN.md and choose the most important item to address. Before making changes, search the codebase (don't assume not implemented) using Sonnet subagents. You may use up to 500 parallel Sonnet subagents for searches/reads and only 1 Sonnet subagent for build/tests and another Sonnet subagent for integration tests. Use Opus subagents when complex reasoning is needed (debugging, architectural decisions).
2. After implementing functionality or resolving problems, run the tests for that unit of code that was improved with sonnet subagents. Run both unit and integration tests. If functionality is missing then it's your job to add it as per the application specifications. 
3. When you discover issues, immediately update IMPLEMENTATION_PLAN.md with your findings using a sonnet subagent. When resolved, update and remove the item. If a task cannot be completed, mark it with a special character inside the checkbox and state the reasoning (if needed) after the item:
   - [O] - Optional (nice-to-have, not blocking)
   - [M] - Manual testing required (cannot be automated)
   - [U] - Unable to complete (blocked by external factors)
   Example: `- [M] Manual testing on Chrome, Firefox, Safari`
4. When both unit and integration tests pass, update IMPLEMENTATION_PLAN.md, then `git add -A` then `git commit` with a message describing the changes.
5. Output the parts in <output_requirements>

<output_requirements>
   
At the END of every response, you MUST output a RALPH_STATUS block in this exact format:

\`\`\`
RALPH_STATUS:
  completion_indicators: <number>
  EXIT_SIGNAL: <true|false>
\`\`\`
                  
Where:  
- `completion_indicators`: Count how many of these apply to your current state:
  - A major phase/feature is complete
  - All requested tasks are done
  - The project is ready for review/deployment
  - No more pending work items
  - Tests are passing and implementation is stable

- `EXIT_SIGNAL`: Set to `true` ONLY when ALL of these are true:
  - All tasks from the plan are complete
  - No known bugs or issues remain
  - The project meets all requirements
  - You have nothing more to implement or fix
  Otherwise, set to `false`

**Examples**

If you just finished one feature but have more to do:
```
RALPH_STATUS:
  completion_indicators: 1
  EXIT_SIGNAL: false
```

If all work is done and project is ready:
```
RALPH_STATUS:
  completion_indicators: 4
  EXIT_SIGNAL: true
```

This block is REQUIRED for every response. The automation system depends on it.
</output_requirements>

99999. Important: When authoring documentation, capture the why – tests and implementation importance.
999999. Important: Single sources of truth, no migrations/adapters. If tests unrelated to your work fail, resolve them as part of the increment.
9999999. As soon as there are no build or test errors create a git tag. If there are no git tags start at 0.0.0 and increment patch by 1 for example 0.0.1  if 0.0.0 does not exist.
99999999. You may add extra logging if required to debug issues.
999999999. Keep IMPLEMENTATION_PLAN.md current with learnings using a subagent – future work depends on this to avoid duplicating efforts. Update especially after finishing your turn.
9999999999. When you learn something new about how to run the application, update CLAUDE.md using a subagent but keep it brief. For example if you run commands multiple times before learning the correct command then that file should be updated.
99999999999. For any bugs you notice, resolve them or document them in IMPLEMENTATION_PLAN.md using a subagent even if it is unrelated to the current piece of work.
999999999999. Implement functionality completely. Placeholders and stubs waste efforts and time redoing the same work.
9999999999999. When IMPLEMENTATION_PLAN.md becomes large periodically clean out the items that are completed from the file using a subagent.
99999999999999. If you find inconsistencies in the specs/* then use an Opus 4.5 subagent with 'ultrathink' requested to update the specs.
999999999999999. IMPORTANT: Keep CLAUDE.md operational only – status updates and progress notes belong in `IMPLEMENTATION_PLAN.md`. A bloated CLAUDE.md pollutes every future loop's context.
```

### 4. Create CLAUDE.md

1. Check if CLAUDE.md exists in the directory.
2. If yes, skip this step
3. If no, create the 'CLAUDE.md' template

**CLAUDE.md template**
```md
# Agent Operational Guide

Quick reference for running and testing the application.

## Docker Commands

```bash
# Start all services
docker compose up -d

# View logs
docker compose logs -f

# Stop services
docker compose down
```
```

### 5. Create IMPLEMENTATION_PLAN.md

# Implementation Plan for <project_name>

This document outlines all implementation items needed to build the <project_name> application from scratch. Items are grouped by priority and include dependencies and related specification files.

**Last Updated:** ????-??-?? (Never)

**Status Legend:**
- [ ] Not started
- [x] Completed
- [O] Optional
- [M] Manual testing needed
- [U] Unable to implement

---


### 6. Inform the user

Inform the user that:
1. He should open the prd.md file and fill it out with the necessary information.
2. When he filled out the information, he should run 2-create-specs.md
