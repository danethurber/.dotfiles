---
name: pr-status
description: Report open pull request status across the user's Parsyl repos. Shows what needs their review, what is blocked, and a priority-ranked table with at-a-glance stats. Use when the user types /pr-status or asks about "my PRs", "PR status", "what needs my review", "what is waiting on me", or "what is on my plate".
---

# PR Status

Print one priority-ranked table of open pull requests. Report only. Take no action on any PR.

## Repos

```
parsyl/insurance-web
parsyl/web-components
```

Edit this list to change coverage. Do not query any other repo.

## Step 1 — Fetch

Run this. It prints one JSON line per PR.

```bash
D="$HOME/.claude/skills/pr-status"
ME=$(gh api user --jq .login)
for r in parsyl/insurance-web parsyl/web-components; do
  gh pr list --repo "$r" --state open --limit 100 \
    --json number,title,author,isDraft,createdAt,mergeable,reviewDecision,statusCheckRollup,reviewRequests,assignees,url \
  | jq -c --arg me "$ME" --arg repo "$r" -f "$D/query.jq"
done
```

Do not add `commits` to the `--json` list. GitHub rejects the query with a node-limit error.

`query.jq` already drops draft PRs and bot-authored PRs. Never add them back.

## Step 2 — Rank

Give every PR a rank. Lower rank prints first.

| Rank | Rule |
|------|------|
| 1 | `mine` is true AND (`ci` is `fail` OR `conflict` is true OR `review` is `CHANGES_REQUESTED`) |
| 2 | `requested` is true OR `assigned` is true |
| 3 | `mine` is true |
| 4 | `review` is `REVIEW_REQUIRED` or `CHANGES_REQUESTED` |
| 5 | everything else |

Apply the first rule that matches. Break ties by `age`, largest first.

## Step 3 — Print

Use this exact shape.

```
## PR Status — 15 Sep 2026

Open 7 · Waiting on you 3 · Yours blocked 1 · CI failing 1 · Oldest 45d

| # | PR | Title | Author | CI | Review | Age | Note |
|---|----|-------|--------|----|--------|-----|------|
| 1 | insurance-web#1692 | Stop background flags fetch discarding a quote form | you | ✓ pass | review required | 7d | assigned to you |
| 2 | insurance-web#1686 | Updates endorsement Header and Overview data | jjyassien | ✗ fail | approved | 7d | review requested |
| 3 | insurance-web#1533 | Disable loss application, show rate impact threshold | jvillegascontractor | ✓ pass | approved | 45d | conflicts · review requested |

Start here: insurance-web#1692 — you are assigned and it still needs review.
```

Rules for the table.

- `PR` is `<repo>#<num>`. Link it to `url`.
- `Title` is shortened to about 60 characters. Strip any leading `feat:`, `fix:`, or `chore:` prefix. Strip any trailing `[is-1234]` ticket tag.
- `Author` prints `you` when `mine` is true. Otherwise print the login.
- `CI` prints `✓ pass`, `✗ fail`, `● pending`, or `– none`.
- `Review` prints `approved`, `changes requested`, `review required`, or `none`.
- `Age` prints `<age>d`.
- `Note` joins these with ` · `, in this order, and stays empty if none apply: `assigned to you`, `review requested`, `conflicts`, `blocked`.

Stats line counts.

| Number | Count of |
|--------|----------|
| Open | all rows |
| Waiting on you | rows where `requested` or `assigned` is true |
| Yours blocked | rows where `mine` is true AND (`ci` is `fail` OR `conflict` OR `review` is `CHANGES_REQUESTED`) |
| CI failing | rows where `ci` is `fail` |
| Oldest | largest `age`, printed as `<n>d` |

Close with one `Start here:` line. Name the rank 1 PR and say in one short clause why it is first. If the table is empty, print `No open PRs. Nothing is waiting on you.` and stop.

## Limits

- Team review requests do not match. Only a direct request to the user sets `requested`.
- Draft PRs never appear. The user chose this.
- Merged and closed PRs never appear.
