# 2. Study prd.md and conduct an interview to create specs/*.md files

Studies the prd.md file and conducts an interview. Then generates the spec documents so that the wigguming can advance further.

## Instructions

1. Study prd.md 
2. Begin a conversation with the user regarding questions, concerns, edges cases, missing data, contradictions and inconsistencies about the document. The goal is to identify Jobs To Be Done (JTBD).
3. After the interview is concluded, break each JTBD into topics, list all the topics with a short description and ask the user if the topics and JTBDs look fine.
4. If yes, then save everything into prd-interview.md file so that if the context gets full or the claude session gets interrupted, the information can be gathered from there.
5. For each topic spawn a sub-agent that creates a specs/<topic name>.md file and then fill up the new specs file with the JTBD for that topic. 
6. At the end, create or update a spec-index.md file that lists all the specs with a short description regarding what it does. 
