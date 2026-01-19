---
description: Analyze and summarize all diary files for the upcoming week (Monday-Sunday)
---

# Plan Next Week

Gather data from both diary markdown files and Google Calendar, then create a comprehensive weekly summary.

## Instructions

### 1. Calculate Next Week's Dates

Determine the dates for the upcoming Monday through Sunday:
- Find the next Monday from today's date
- Calculate all 7 days: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
- Format each date as `YYYYMMDD` (e.g., `20260112`)

Example: If today is Saturday 2026-01-10, next week is:
- Monday: 20260112
- Tuesday: 20260113
- Wednesday: 20260114
- Thursday: 20260115
- Friday: 20260116
- Saturday: 20260117
- Sunday: 20260118

### 2. Launch Two Parallel Sub-agents

Launch **both sub-agents in parallel** (in a single message with two Task tool calls).

#### Sub-agent 1: Diary Files Analyzer

```
Analyze diary markdown files for next week ({START_DATE} to {END_DATE}).

1. Check which files exist at: /home/sloby/notes/Main Vault/Diary/YYYYMMDD.md
   Files to check: {LIST_OF_YYYYMMDD}.md

2. For each existing file:
   - Read the file content
   - Count unchecked tasks (- [ ] pattern)
   - Count checked/completed tasks (- [x] pattern)
   - Extract main topics/themes
   - Write a 1-2 sentence summary

3. Return a structured response for each day:
   - Day: {DAY_NAME}
   - Date: {DATE_FORMATTED}
   - File exists: Yes/No
   - Unchecked tasks: X
   - Completed tasks: X
   - Topics: [list of topics]
   - Summary: [brief summary]

Return all 7 days, marking non-existent files as "Empty/No diary entry".
```

#### Sub-agent 2: Google Calendar Fetcher

```
Fetch Google Calendar events and tasks for next week.

1. Run this command:
   cd /home/sloby/projects/personal/gcal-integration && uv run gcal --json --primary-only

2. Parse the returned JSON which has this structure:
   {
     "date_range": { "start": "...", "end": "..." },
     "events": [
       {
         "summary": "Event name",
         "start_time": "2026-01-12T11:00:00",
         "end_time": "2026-01-12T13:00:00",
         "description": "...",
         "location": "...",
         "is_all_day": false
       },
       ...
     ],
     "tasks": [
       {
         "title": "Task name",
         "due_date": "2026-01-16T00:00:00",
         "is_completed": false,
         "notes": "..."
       },
       ...
     ]
   }

3. Group events by day (use start_time date)

4. Return a structured response:
   - For each day (Monday-Sunday):
     - Day: {DAY_NAME}
     - Date: {DATE}
     - Events: [list with time and summary]
     - Tasks due: [list of tasks due that day]
   - Total events: X
   - Total tasks: X
```

### 3. Compile Unified Weekly Summary

After both sub-agents complete, merge their results into this format:

```markdown
# Next Week Overview (Mon {START_DATE} - Sun {END_DATE})

## Daily Breakdown

### Monday {DATE}

**Diary:** {Status: Defined/Empty}
{If defined: X unchecked tasks, X completed}
{Summary from diary or "No diary entry"}

**Calendar Events:**
{List events with times, or "No events"}

**Tasks Due:**
{List tasks due this day, or "No tasks due"}

---

### Tuesday {DATE}
...

### Wednesday {DATE}
...

### Thursday {DATE}
...

### Friday {DATE}
...

### Saturday {DATE}
...

### Sunday {DATE}
...

## Week at a Glance

| Day | Diary | Events | Tasks Due | Notes |
|-----|-------|--------|-----------|-------|
| Mon | {status} | {count} | {count} | {brief} |
| Tue | {status} | {count} | {count} | {brief} |
| Wed | {status} | {count} | {count} | {brief} |
| Thu | {status} | {count} | {count} | {brief} |
| Fri | {status} | {count} | {count} | {brief} |
| Sat | {status} | {count} | {count} | {brief} |
| Sun | {status} | {count} | {count} | {brief} |

## Summary Statistics

**From Diary:**
- Days with diary entries: X/7
- Total unchecked tasks: X
- Total completed tasks: X

**From Google Calendar:**
- Total events: X
- Total tasks due: X

**Empty days that need planning:** {list days with no diary AND no events}

## Recommendations
{If there are completely empty days, suggest planning them}
{If workload looks unbalanced, note it}
{If there are busy days with many events, highlight them}
```

### 4. Output

Present the compiled weekly summary to the user.
