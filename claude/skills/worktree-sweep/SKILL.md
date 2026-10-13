---
name: worktree-sweep
description: Report a repo's git worktrees and local branches, propose which to remove, prune or keep, and remove them only after approval. Use when asked to clean up, list or audit worktrees or local branches, or when worktrees have piled up.
---

# worktree-sweep

Worktrees pile up: every session and every stacked PR makes one, and nothing removes them. This skill reports them and, with sign-off, removes the ones that hold nothing.

## Report

Run from the repo root. It is read-only.

```bash
python3 -I ~/.claude/skills/worktree-sweep/report.py --branches
```

It prints one table of worktrees and one of local branches, each with an action and a reason:

| Action | Meaning |
| --- | --- |
| `remove` | The PR merged and the branch is fully in it (by commit or by patch), or the worktree is detached at a commit that exists elsewhere. No changes. |
| `prune` | The folder is gone. Only git's record is left. |
| `delete` | A branch whose merged PR holds every one of its commits. |
| `keep` | An open PR, unmerged analytics or Colada work, a `backup/` branch, the main worktree, a process using it now, or a commit in the last hour. |
| `ask` | Uncommitted changes, a closed PR, no PR, or commits the merged PR lacks. |

Show the user the counts, every `ask` row, and the list to remove. Then stop and wait for approval.

## Apply, after approval

1. **Remove worktrees** one at a time with `git worktree remove <path>`, without `--force`. Git refuses a worktree that has changes, which is the safety net. This is slow because of `node_modules`; run it in the background.
2. **Prune** with `git worktree prune -v`.
3. **Back up branches** before you delete any. Write the approved branch names to a file, then run `git bundle create .scratch/backups/$(date +%F)-deleted-branches.bundle $(sed 's|^|refs/heads/|' <file>)`, then `git bundle verify` it.
4. **Delete branches** with `xargs git branch -D < <file>`. A squash merge makes `-d` refuse, so `-D` is expected. If the tool denies the command, stop and give the user the command to run.

To restore a branch: `git fetch .scratch/backups/<date>-deleted-branches.bundle <branch>:<branch>`.

## Rules

- Never remove a worktree with uncommitted changes. For an `ask` row with changes, offer to save the diff or the untracked files first.
- Never touch a worktree that another session uses. The report checks running processes and commits in the last hour, but a session can also be idle. When unsure, ask.
- Never delete `master`, `main`, a `backup/` branch, or unmerged analytics or Colada work. Once its PR merged and the branch is fully in it, an analytics or Colada branch goes like any other.
- Never delete remote branches.
