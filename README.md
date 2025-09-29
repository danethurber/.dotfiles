## Installation Guide

clone the repo

```
cd ~/
git clone git@github.com:danethurber/.dotfiles.git
```

run the bootstrap command

```
./bootstrap.sh
```

## Neovim (LazyVim)

LazyVim will auto-bootstrap on first launch. Custom plugins are in `nvim/lua/plugins/`:
- **claude.lua** - Claude Code integration
- **python.lua** - Python LSP, DAP, venv management
- **formatting.lua** - black, isort, prettier
- **linting.lua** - flake8
- **telescope.lua** - file search exclusions
- **editor.lua** - EditorConfig support

## tmux

- load up tmux and install plugins with prefix+I

## iTerm2

- config iterm to use the color profile found in this repo

