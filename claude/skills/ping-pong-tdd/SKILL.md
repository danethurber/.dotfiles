---
name: ping-pong-tdd
description: Pair on an implementation via ping-pong TDD — alternating red/green rounds between the agent and the user. Use when the user says "ping-pong" or asks to alternate writing failing tests and making them pass.
---

# Ping-Pong TDD

One rhythm: **red** (a failing test), **green** (it passes), then swap or repeat.

## Roles

Ask, if not already stated: **strict alternation** (canonical form — whoever just went green immediately drafts the next red) or **fixed roles** (one side always writes tests, the other always implements — useful when the user is deliberately racking up implementation reps to learn a stack or codebase). Default to fixed roles, agent writing tests and user implementing, unless told otherwise. State the choice once, out loud, before round 1.

## The loop

1. **Red.** Write exactly one failing test for the smallest next slice of behavior — one new assertion, not a batch. Run it. Confirm it fails for the reason you expect (not a typo, import error, or unrelated crash) — a red that fails for the wrong reason isn't red, it's broken.
2. **Hand off.** State plainly what the test expects, then stop.
3. **Green.** The other side writes the minimum code that turns the test green — no behavior beyond what the test demands, no refactoring yet.
4. **Confirm.** Run the full suite, not just the new test — a pass that breaks something else isn't green. Only move on once the whole suite is green; if anything's red, hand back what's failing and why.
5. **Refactor, optionally.** Only on green. Either side may propose it; re-run the suite green again afterward.
6. **Swap or repeat.** Strict alternation: the side that just went green drafts the next red. Fixed roles: the same test-writer drafts the next red. Either way, back to step 1.

## Stopping

Done means every case on the agreed behavior list — from a plan, spec, or the feature's acceptance criteria — has a passing test, not "no obvious cases left." Check that list explicitly before calling the loop finished.
