# Create a prd file with a predefined template

# Variables

prd_filename=$1

# Workflow

1. If <prd_filename> is not provided, it will be prd.md
2. `cp ~/.claude/commands/ralph/templates/prd-template.md <prd_filename>`
