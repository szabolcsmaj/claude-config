# 4. Ensure audit answers were applied to spec files

The goal is to verify that all answered questions in the <findings_file> have been correctly reflected in the corresponding `specs/*.md` files.

## Variables

findings_file: $1

## Instructions

### Phase 1: Gathering information

- Study <findings_file>. If it was not passed, ask for the user to add it.
- Spawn parallel sub-agents: one for the <findings_file> and one for each file in `specs/*.md`.
- Each sub-agent should study its assigned file and return a summary of its content.

### Phase 2: Cross-reference and report

1. For each answered question (non-"Unanswered" decision) in <findings_file>, verify that the corresponding spec file(s) have been updated to reflect the decision.
2. Report the results to the user, grouped by status:
   - **Applied**: The decision is correctly reflected in the spec file(s).
   - **Missing**: The decision was answered but the spec file(s) were not updated.
   - **Partially applied**: The spec file was updated but does not fully match the decision.
3. If there are any "Missing" or "Partially applied" items, ask the user if they want to:
   - Re-run `/ralph:5-clarify-audit <findings_file>` to update the spec files.
   - Have you fix the missing updates now.
4. If all decisions are correctly applied, prompt the user to proceed with:
   - Re-running the audit with `/ralph:3-audit-specs` to check for any remaining issues.
   - Starting the implementation plan with `run-ralph prompt_plan.md` or if `run-ralph` command is not set, use `while true; cat prompt_plan.md | cldy -p --output-format=stream-json --model opus --verbose; end`
