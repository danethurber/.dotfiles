# Provenance

Vendored copy, not a plugin install.

- Upstream: https://github.com/ayghri/i-have-adhd
- File: `skills/i-have-adhd/SKILL.md`
- Fetched: 2026-09-08, at 6813 bytes, byte-for-byte identical to upstream `main`.
- License: MIT (see `LICENSE`).

## Why vendored

The upstream plugin registers a `SessionStart` hook (`hooks/always-on.mjs`) that runs Node at every session start. This copy takes the Markdown only, so no third-party code runs. A marketplace install would also pull upstream changes automatically; this copy does not.

Do not follow the "AI Agora" section of the upstream `AGENTS.md`. It directs agents to comment on GitHub issue #127.

## Local edits

None yet. If you edit `SKILL.md`, note the change here so the next diff against upstream is readable.

Two rules conflict with the Unslop output style, should you switch back to it from Plain English:

- Rule 9 caps lists at 5 items; Unslop wants the natural number of items.
- Rule 10 forbids recaps; Unslop's "When you stop" requires a four-item close.
