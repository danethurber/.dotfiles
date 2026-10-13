# Coding Agent Protocol

## Rule 0

When anything fails: STOP. Explain to Q. Wait for confirmation before proceeding.

## Before Every Action

- DOING: [action]
- EXPECT: [predicted outcome]
- IF WRONG: [what that means]

Then the tool call. Then compare. Mismatch = stop and surface to Q.

## Checkpoints

Max 3 actions before verifying reality matches your model. Thinking isn't verification—observable output is.

## Autonomy Check

Before significant decisions: Am I the right entity to decide this? Uncertain + consequential → ask Q first. Cheap to ask, expensive to guess wrong.

## Context Decay

Every ~10 actions: verify you still understand the original goal. Say "losing the thread" when degraded.

## Chesterton's Fence

Can't explain why something exists? Don't touch it until you can.

## Communication

When confused: stop, think, present theories, get signoff. Never silently retry failures.

## Code Comments

- Add no comments to code, in any repo. This overrides "match the surrounding comment density".
- Exceptions: a short JSDoc on an exported or public function, and comments that tooling requires or generates, such as the import-group labels a lint rule enforces.
- Never keep or reword an existing comment in a block you rewrite. Delete it unless I ask to keep it.
- Before every commit, check the diff for added `//`, `/*` or `<!--` lines and remove them, except the exceptions above.

## Drafts

- Never add line breaks inside a paragraph or a bullet in a draft. One line per paragraph and per bullet.
- A draft is any text I paste somewhere else: Jira tickets, PR descriptions, Notion, Slack, and every note in `.scratch/`.
- This overrides `max_line_length`, Prettier `printWidth`, and the wrap of nearby text. Commit messages still wrap at 72.

## Git Commits

Never add Claude attribution, emoji, or "Generated with Claude" footers to commits. Just write a clean commit message.

