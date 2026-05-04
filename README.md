# Dotfiles

Minimal, modern dotfiles for macOS.

## Quick Start

```bash
cd ~
git clone git@github.com:danethurber/.dotfiles.git
cd .dotfiles
./bootstrap.sh
```

## What's Included

| Component | Description |
|-----------|-------------|
| **Zsh + Antidote** | Fast shell with lazy-loaded plugins (aws, git, docker, nvm) |
| **Starship** | Two-line prompt with git, node, python, docker, aws (plain text symbols) |
| **LazyVim** | Modern Neovim config with LSP, formatting, linting |
| **Git** | Aliases, GPG signing, custom merge tools |
| **MCP configs** | Claude Desktop and Cursor MCP server templates |
| **ccstatusline** | Claude Code statusline with model, context, git, usage widgets |

## Structure

```
.dotfiles/
├── Brewfile              # Homebrew packages
├── bootstrap.sh          # Setup script
├── zsh/
│   ├── .zshrc            # Shell config (Antidote-based)
│   └── .zsh_plugins.txt  # Plugin list
├── starship/
│   └── starship.toml     # Prompt config (two-line, plain text symbols)
├── nvim/                 # LazyVim config
├── mcp/                  # MCP server configs
├── iterm/
│   └── Nord.itermcolors  # iTerm2 color theme
├── .gitconfig            # Git aliases and settings
├── .editorconfig         # Editor formatting
├── .claude/              # Claude Code settings
└── ccstatusline/
    └── settings.json     # ccstatusline config (symlinked to ~/.config/ccstatusline/)
```

## Secrets

Create `~/.env` for secrets (not committed):

```bash
export MATTERBEAM_API_TOKEN="xxx"
export MATTERBEAM_CUSTOMER_KEY="xxx"
```

This is sourced by `.zshrc` and used by `bootstrap.sh` to populate MCP templates.

## Post-Install

1. **iTerm2**: Import `iterm/Nord.itermcolors` color scheme
2. **Neovim**: Run `nvim` - LazyVim auto-bootstraps on first launch
3. **Claude Code plugins**: Run `/plugin install` for each in `enabledPlugins`

## LazyVim Plugins

Custom plugins in `nvim/lua/plugins/`:
- **claude.lua** - Claude Code integration
- **python.lua** - Python LSP, DAP, venv management
- **formatting.lua** - black, isort, prettier
- **linting.lua** - flake8
- **telescope.lua** - file search exclusions
- **editor.lua** - EditorConfig support
