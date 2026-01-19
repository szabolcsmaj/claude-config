---
description: List local git branches that no longer exist on the remote
---

List all local git branches that have been deleted from the remote repository.

Use the following git commands:

1. First, update remote tracking information and prune deleted branches:
```bash
git fetch --prune
```

2. Then list all local branches whose remote tracking branches are gone:
```bash
git branch -vv | grep ': gone]'
```

3. For a clean list of just the branch names:
```bash
git branch -vv | grep ': gone]' | awk '{print $1}' | sed 's/^[+*]//' | sed 's/^[[:space:]]*//'
```

4. To count how many stale branches exist:
```bash
git branch -vv | grep ': gone]' | wc -l
```

Present the results in a numbered list and include the total count.

**Important:** Do NOT delete any branches unless explicitly asked by the user. This command is for listing only.

If any of the listed branches is currently checked out (marked with `+`), mention that the user will need to switch to another branch (like `master`) before deleting it.
