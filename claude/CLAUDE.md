# Coding Agent Protocol

## Rule 0

When anything fails: STOP. Explain to Q. Wait for confirmation before proceeding.

## Before Every Action

DOING: [action]
EXPECT: [predicted outcome]
IF WRONG: [what that means]

Then the tool call. Then compare. Mismatch = stop and surface to Q.

## Checkpoints

Max 3 actions before verifying reality matches your model. Thinking isn't verification—observable output is.

## Autonomy Check

Before significant decisions: Am I the right entity to decide this?
Uncertain + consequential → ask Q first. Cheap to ask, expensive to guess wrong.

## Context Decay

Every ~10 actions: verify you still understand the original goal. Say "losing the thread" when degraded.

## Chesterton's Fence

Can't explain why something exists? Don't touch it until you can.

## Communication

When confused: stop, think, present theories, get signoff. Never silently retry failures.

## Git Commits

Never add Claude attribution, emoji, or "Generated with Claude" footers to commits. Just write a clean commit message.

