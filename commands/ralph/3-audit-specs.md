# 3. Audit specs/*.md files for errors and inconsistencies 

The goal is to check for errors, inconsistencies and edge cases in spec files and report these back to the user and save them into a file.

## Variables

findings_file: $1

## Instructions

### Phase 1: Gathering information

- Spawn parallel sub-agent for each md file in `specs/*.md` and study each file. 
- Look for inconsistencies, missing edges cases, errors, and contradictions in each of these specifications. 
- Collect these and then pass them back to the main agent.

### Phase 2: Summarize findings

1. If every sub-agent is finished, present the findings to the user by categorizing the type of errors
2. Focus on urgent or critical issues first.
3. Save the findings into <findings_file>. If no <findings_file> was specified, create a new one with the name of `audit_findings.md`. If this file already exists, create a new one with a suffix of `_1` (e.g.: `audit_findings_1.md`, etc)
4. The <findings_file> should group the different issues under topics, then under each topic, it should list all related issues by number, state the question, then state a decision under it. The decision part should have the value of "Unanswered"
5. Prompt the user to execute `/ralph:4-clarify-audit <findings_file>` command to got through the audit findings.

Example for the <findings_file>:
```md
## Security-Critical Decisions
 
### Q1: Password Special Character Requirements
**Issue**: CSC-1, readme.md vs users.md conflict
**Question**: Are special characters required in passwords?
 
**Decision**: Unanswered
```
