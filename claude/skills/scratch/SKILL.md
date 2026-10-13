---
name: scratch
description: Create, audit and clean up a repo's `.scratch/` notes bundle (an Open Knowledge Format folder with its own index.md). Use whenever writing a note, plan, ticket draft, PR description, research or reference doc into `.scratch/`, and when asked to clean up, audit, sort, promote or reorganize `.scratch`.
---

# scratch

`.scratch/` is a gitignored notes bundle. Its rules live in its own `index.md`, which is the authority: read it before you write, move or delete anything. Nothing in `.scratch` has git history, so a wrong move or delete loses work for good.

Scripts are in `~/.claude/skills/scratch/scripts/`. Run them with `python3 -I` from the repo root. The bundle path is `.scratch`.

## Write a note

Never write frontmatter from memory. Create the file with `new.py`, then write the body into it:

```bash
python3 -I ~/.claude/skills/scratch/scripts/new.py .scratch <kind> <slug> "<Title>"
```

| Kind | Use it for | Lands in |
| --- | --- | --- |
| `note` | Anything unsorted, a PR description, a commit plan, a Jira comment draft | top level, `yyyy-mm-dd-slug.md` |
| `plan` | Work in flight | `plans/yyyy-mm-dd-slug.md` |
| `ticket` | A Jira ticket draft. Pass `CL-123-slug` once it is filed | `tickets/draft-slug.md` |
| `reference` | How a thing works | `docs/slug.md` |
| `research` | Why a decision was made, findings, a spike, a review | `context/slug.md` |
| `adr` | A draft ADR. The number is the next free one across `.scratch/adrs` and the repo | `adrs/NNN-slug.md` |

The script fills `type`, `status`, `stale_after` and `generated.at` from the home's row in `index.md`. It prints the path.

Rules for the body:
- No line breaks inside a paragraph or a bullet. One line each, however long. Drafts get pasted into Jira, GitHub, Notion and Slack, which keep every break.
- Links to other notes are bundle-relative: `/plans/2026-10-09-x.md`. A repo path has no leading slash: `docs/adrs/009-domain-package-contract.md`.
- Say what you verified and what you assumed.
- One plan per topic. Before you create a plan, search for an existing one and extend it instead.
- When you edit an existing note, set `generated.at` to now and never change the date in its filename.

## Audit

```bash
bash ~/.claude/skills/scratch/scripts/sweep.sh .scratch
```

Read-only. It reports misplaced types, values outside the vocabulary, stale notes, wrong stale windows, filename breaks, broken links and line breaks. `index.md` maps stray types and statuses to the defined ones.

## Clean up

Use this when the user asks to clean up, sort or reorganize `.scratch`. Every step that changes files waits for the user's approval.

1. **Gather evidence.** Run `python3 -I ~/.claude/skills/scratch/scripts/evidence.py .scratch`. It prints a JQL `key in (...)` query. Run it with the Atlassian MCP `searchJiraIssuesUsingJql`, write the results as `KEY<TAB>Status` lines to a file in the session scratchpad, then rerun with that file as the second argument. You get each note's Jira and PR states.
2. **Judge each note.** For more than about 30 notes, split them across 2 or 3 subagents by date or folder. Give each one `index.md`, the evidence file and the owner rules below. Each note gets one verdict: delete, move (with the new path), merge into another note, keep, or ask. Each verdict needs one sentence of evidence.
3. **Write the plan** as a top-level note with `new.py`. Include a totals table and one table per verdict. Show the user the totals and the questions, then stop and wait.
4. **Back up.** Do this before anything changes: `tar -czf .scratch/backups/$(date +%F)-scratch-before-cleanup.tar.gz --exclude=./backups -C .scratch .`
5. **Delete.** Write the approved paths to a list file, one per line, then run `cd .scratch && xargs rm -- < <list>`. Do not run `rm` inside `bash -c` or a script: the safety check blocks it.
6. **Merge.** Append the parts to keep to the target under `## <title>`, followed by a line naming the deleted source. Set the top merged heading to level 3. Delete the source afterwards.
7. **Move.** Write `old<TAB>new` lines to a file, then run `python3 -I ~/.claude/skills/scratch/scripts/move.py .scratch <file>`. It sets the frontmatter for the new home, removes line breaks and rewrites every link. It skips a note written in the last hour, because another session may own it. Report the skipped notes and leave them in place.
8. **Repair.** Rerun the audit. Fix the links it reports: repoint them to the merge target, or keep the link text and drop the link. Run `unwrap.py` on the notes it lists.
9. **Update memory.** Search the project memory folder for `.scratch/` paths that moved or were deleted, and update them.

Owner rules that hold in every cleanup:
- Never delete a note about unmerged analytics or Pinia Colada work. Keep it or move it. Once that work merged, its notes follow the normal rules.
- A plan is deleted when its work ships. Reasoning worth keeping moves to `context/` first.
- A ticket draft is deleted when Jira holds everything in it.
- A PR body or commit plan is deleted when its PR merges.
- Keep `backups/*.bundle` files. They hold branches that exist nowhere else.
- Never set `verified`. Only a human sets it.
