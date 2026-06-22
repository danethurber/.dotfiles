# Dotfiles

Minimal, modern dotfiles for macOS development (Python, Go, TypeScript/Node).

## Quick Start

```bash
xcode-select --install
git clone git@github.com:danethurber/.dotfiles.git ~/.dotfiles
~/.dotfiles/bootstrap.sh
```

`bootstrap.sh` is idempotent (safe to re-run). For the manual steps it can't script
(1Password signing, `gh auth`, macOS permissions), follow **[SETUP.md](SETUP.md)**.

## What's Included

| Component | Description |
|-----------|-------------|
| **Ghostty** | GPU terminal, Nord theme, Hack Nerd Font (daily driver) |
| **Zsh + Antidote** | Fast shell with static plugin bundle (aws, git, docker, completions) |
| **Starship** | Two-line prompt (git, node, python, docker, aws) |
| **LazyVim** | Neovim with LSP/format/lint for Python, Go, TS/Vue/React, JSON, TOML, Markdown |
| **VSCode** | Settings, keybindings, and extension list tracked in-repo |
| **Version mgmt** | `mise` (Node, Go, Python interpreters) · `uv` (Python venvs) |
| **Git** | Rich aliases, delta diffs, SSH commit signing via 1Password |
| **Claude Code** | Global CLAUDE.md protocol, plugins, ccstatusline, per-stack project templates |

## Version management

Two tools, clear division of labor:

- **mise** owns **Node, Go, and Python interpreters** (`mise/config.toml`; reads `.nvmrc`
  and `.python-version`).
- **uv** owns **Python project venvs** (`.venv`, auto-sourced via mise's `uv_venv_auto`).

## Structure

```
.dotfiles/
├── Brewfile              # Homebrew packages (CLIs, Ghostty, VSCode, fonts)
├── bootstrap.sh          # One-command provisioning (idempotent)
├── SETUP.md              # Manual checklist (1Password, gh, permissions)
├── macos.sh              # Optional macOS `defaults` tweaks
├── zsh/                  # Shell config (Antidote-based)
├── starship/             # Prompt config
├── nvim/                 # LazyVim config
├── ghostty/config        # Terminal config
├── mise/config.toml      # Node + Go + Python runtime management
├── vscode/               # settings.json, keybindings.json, extensions.txt
├── claude/               # CLAUDE.md protocol, settings, templates/
├── ccstatusline/         # Claude Code statusline config
├── .gitconfig            # Git aliases + SSH signing
└── .editorconfig         # Editor formatting
```

## Secrets

Create `~/.env` for secrets (not committed); sourced by `.zshrc`:

```bash
export SOME_API_TOKEN="xxx"
```

## Claude Code

- Global protocol: `claude/CLAUDE.md` → symlinked to `~/.claude/CLAUDE.md`.
- Project starter: `claude/templates/project-CLAUDE.md` (Python/Go/Node sections) — copy
  into a new repo as its `CLAUDE.md` and keep the stack section you need.
- Plugins: run `/plugin install` for each in `claude/settings.json` `enabledPlugins`.

## Neovim plugins

Custom plugins in `nvim/lua/plugins/`:
- **claude.lua** — Claude Code integration
- **python.lua** — Python LSP/DAP, uv commands, venv management
- **formatting.lua** — conform.nvim overrides (ruff for Python, taplo for TOML); Go (gofumpt)
  and web filetypes (prettier) come from LazyVim extras
- **picker.lua** — snacks.picker file/grep exclusions

Language support (gopls, vtsls, Volar, ESLint, Prettier, etc.) comes from LazyVim extras
declared in `nvim/lazyvim.json`. `bootstrap.sh` syncs the plugins headlessly; the LSP/
formatter **binaries install via Mason the first time you open a file of that type**.
