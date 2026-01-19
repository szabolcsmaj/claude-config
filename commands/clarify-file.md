# Plan Clarification

Conduct an interactive clarification session to gather missing details from a plan file before implementation. Ask questions to resolve ambiguities and missing information.

## Variables
plan_file: $1

## Instructions

### Phase 1: Analysis

1. **Read the Plan**
   - Read the <plan_file> content
   - Identify what information is already provided
   - Look for application, module, or file names mentioned

2. **Read Project Context**
   - Check for any CLAUDE.md files to understand project architecture and requirements
   - Use this context to inform your questions

3. **Identify Information Gaps**
   - Find ALL unclear or missing information:
     - **Critical**: Must-have information for implementation
     - **Helpful**: Nice-to-have details for better understanding
   - Common gaps to look for:
     - Which specific files/directories are involved?
     - What is the expected behavior or output?
     - Are there any constraints or dependencies?
     - What does success look like?
   - If the plan is already clear and complete, acknowledge this and skip to Phase 3

### Phase 2: Interactive Questioning

**IMPORTANT**: This is a conversational, iterative process.

1. **One Question at a Time**
   - Ask the FIRST highest-priority gap as a clear question
   - Briefly explain WHY this information is needed
   - Ask only ONE question per interaction
   - Wait for the user's response before continuing

2. **Process User Response**
   - After each response, evaluate:
     - Is it sufficient to fill the gap?
     - Does it raise new questions?
     - Does it change your understanding?

3. **Adaptive Questioning**
   - Add new questions based on answers
   - Re-prioritize remaining questions
   - Ask follow-up questions for vague or incomplete answers
   - The number of questions is variable (0 to many)

4. **Stopping Criteria**
   - Stop when:
     - All critical gaps are filled with sufficient detail
     - User indicates "done" or "ready to proceed"
     - You have enough information for implementation
   - Don't over-question - respect the user's time

5. **Handling Special Cases**
   - **User doesn't know**: Note as unknown, ask if they can find out, or proceed without
   - **User wants to skip**: Allow exit
   - **Already complete**: If plan has all needed info, acknowledge and skip questioning

### Phase 3: Synthesize Information

1. **Review the Conversation**
   - Look back at all questions and answers from the session
   - Extract key facts, details, and decisions
   - Organize information by logical categories

2. **Create Summary**
   - Create bullet points that are:
     - Short but thorough
     - Actionable for implementation
     - Organized into clear categories
   - Avoid verbatim Q&A - synthesize into direct statements

3. **Present Clarifications**
   - Format with this structure:

   ```markdown
   # Clarifying Details for [Plan Name]

   ## [Category 1]
   - Detail point 1
   - Detail point 2

   ## [Category 2]
   - Detail point 1
   - Detail point 2
   ```

   Common category examples:
   - Scope & Files
   - Expected Behavior
   - Technical Requirements
   - Constraints
   - Success Criteria

## Example Interaction Flow

**Start:**
"I've reviewed the plan file. Let me ask some questions to clarify ambiguous or missing details."

**Question:**
"Question: [Specific question about the plan]
(This helps ensure [why it's important])"

[Wait for response]

**Follow-up:**
"Thanks! That clarifies [aspect]. Let me ask about [next question]..."

[Continue until sufficient]

**Complete:**
"Perfect! I have enough information. Here's the summary of clarifying details..."

## Notes

- Be conversational and efficient
- Don't ask for information that's already clear in the plan
- Let answers guide the conversation
- Stop when you have enough for implementation
- Focus on what's truly needed, not exhaustive detail
