# Use squirrelscan-cli to audit a website

# Variables

website=$1

# Workflow

1. Check if the user provided <website>. If not, ask for it.
2. Run `npx squirrelscan audit <website>` in a haiku subagent with timeout of 3 minutes. Save the audit into a temp file in `/tmp` directory.
3. Report back the audit file in the `/tmp` directory to the main agent. Only summarize at the end.
4. Ask the user if he wants to talk about the errors, warnings, and info reports and find out how to fix them.
5. If the output is needed again, just run read the audit file in the `/tmp` dir to retrieve the report.
