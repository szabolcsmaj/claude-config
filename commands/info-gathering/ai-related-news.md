---
description: Search Reddit, X.com, and Hacker News for AI-related news, summarized for social media
---

# AI-Related News Gathering

Search Reddit, X.com (Twitter), and Hacker News for recent AI-related news and discussions. Focus on two categories:

1. **Things that impact the day-to-day life of regular people** (healthcare, jobs, scams, education, regulation, consumer tools, viral discussions)
2. **Tech-related stuff that affects software developers** (AI coding tools, LLM releases, developer productivity, frameworks, job market, security)

## Instructions

1. **Launch 6 haiku subagents in parallel** using the Task tool (`model: haiku`, `subagent_type: general-purpose`). Each agent searches one combination:
   - Reddit + regular people impact
   - Reddit + software developer impact
   - X.com + regular people impact
   - X.com + software developer impact
   - Hacker News + regular people impact
   - Hacker News + software developer impact

2. **Each subagent should:**
   - Use WebSearch to find recent news and discussions (focus on the last 1-2 weeks)
   - Search with `site:reddit.com`, `site:x.com`, or `site:news.ycombinator.com` prefixes, plus broader queries
   - Return at least 5-8 findings per category
   - Include for each finding: a brief summary, why it matters, and the source URL

3. **After all agents complete, compile a curated summary** organized into two sections:
   - "For Regular People" - the most interesting/impactful findings
   - "For Software Developers" - the most relevant tech findings

4. **Format each item** as a social-media-ready snippet:
   - Bold headline (max ~10 words)
   - 2-3 sentence summary explaining what happened and why it matters
   - Source URL(s)

5. **Deduplicate** findings that appear across multiple agents. Prioritize items that are:
   - Genuinely surprising or counterintuitive
   - Backed by data or specific events (not just opinion pieces)
   - Highly shareable / conversation-starting

6. **Aim for 5-8 items per category** in the final output.
