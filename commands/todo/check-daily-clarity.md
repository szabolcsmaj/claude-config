---
description: Categorize diary tasks and notes into Clear, Vague, or Undefined
---

# Check Daily Clarity

Analyze the tasks and notes in an Obsidian diary note and categorize them by how well-defined they are.

## Instructions

1. **Find the target file:**
   - If an argument is provided (`$ARGUMENTS`), look for: `/home/sloby/notes/Main Vault/Diary/$ARGUMENTS.md`
   - If NO argument is provided, use Glob to find all `.md` files in the root of `/home/sloby/notes/Main Vault/Diary/`, sort by filename descending (files are YYYYMMDD.md format), and pick the first one

2. **Read the file** using the Read tool. This file contains tasks and notes for that day.

3. **Extract all unchecked tasks** - lines matching `- [ ]` pattern, including nested ones with indentation

4. **Categorize each task into one of three categories:**

   **Clear** - Well-defined, actionable tasks:
   - Has a specific action verb (send, fix, create, review, call, etc.)
   - Has a clear deliverable or outcome
   - Has enough context to start immediately

   **Vague** - Has direction but lacks specifics:
   - General action but missing details
   - Unclear scope or definition of done
   - Needs clarification before execution

   **Undefined** - Not really tasks:
   - Just links/URLs without action text
   - Reflections, thoughts, journal entries
   - Headers or section markers
   - Questions without clear follow-up

5. **Output the results** in this format:

### File Analyzed
`{filepath}`

### Clear
| Task | Reason |
|------|--------|

### Vague
| Task | Reason | Suggestion |
|------|--------|------------|

### Undefined
| Item | Reason |
|------|--------|

### Summary
| Category | Count | % |
|----------|-------|---|
| Clear | X | X% |
| Vague | X | X% |
| Undefined | X | X% |
| **Total** | **X** | **100%** |
