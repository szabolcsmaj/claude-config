# 4. Clarify the issues in the audit findings, then update specs/*.md files

The goal is to study the <findings_file> (argument) and conduct an interview with the user to answer the questions presented there. After the questions are answered, the spec files will be updated to contain the new provided information.

## Variables

findings_file: $1

## Instructions

### Phase 1: Conducting interview

- Study <findings_file>. If it was not passed, ask for the user to add it.
- Conduct an interactive interview where you go through each issue/question in the <findings_file> and present the user with possible answers.
- When the user answers a question in the <findings_file>, update the <findings_file> with the answer and the reasoning.

Example for an updated <findings_file> issue:
```md
## Security-Critical Decisions
 
### Q1: Password Special Character Requirements
**Issue**: CSC-1, readme.md vs users.md conflict
**Question**: Are special characters required in passwords?
 
**Decision**: No special characters required. Password requirements are:
- Minimum 8 characters
- At least one uppercase letter
- At least one lowercase letter
- At least one number
- Special characters are allowed but not mandatory
 
**Action**: Update readme.md to remove special character requirement.
```

### Phase 2: Update spec files

- Spawn parallel subagents for each spec file in `specs/*.md` and study them.
- Based on the updated content of the <findings_file>, update all the files in `specs/*.md` that needs updating, or if new ones need to be created. Do this by spawning parallel subagents.
- When the spec files are updated, include the list of updated/created spec files in <findings_file>, including the issue numbers that are related to them.
- Ask the user if:
   - Whether he wants to rerun the audit on the spec files again with the '/3-audit-specs' command?
   - Or if he wants to start creating the implementation plan with `while true; cat prompt_plan.md | cldy -p --output-format=stream-json --model opus --verbose; end`
