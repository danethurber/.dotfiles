# ~/.zshrc - Minimal zsh config with Antidote

# ----- Environment -----
export EDITOR=nvim
export VISUAL=nvim
bindkey -e
unset GIT_EDITOR  # Prevent Cursor's remote-containers extension from overriding
export VIRTUAL_ENV_DISABLE_PROMPT=1  # Let starship handle venv display
export PNPM_HOME="$HOME/Library/pnpm"

# PATH
export PATH="./node_modules/.bin:$HOME/.local/bin:$HOME/.npm-global/bin:/opt/homebrew/opt/libpq/bin:$PNPM_HOME:$PATH"

# Clear stale VIRTUAL_ENV inherited from a parent process (e.g. an editor
# launched from a shell with a since-deleted venv active). If the venv
# directory is gone, the env var and its bin/ entry on PATH are lies.
if [[ -n "$VIRTUAL_ENV" && ! -d "$VIRTUAL_ENV" ]]; then
  PATH="${PATH//${VIRTUAL_ENV}\/bin:/}"
  PATH="${PATH//:${VIRTUAL_ENV}\/bin/}"
  unset VIRTUAL_ENV VIRTUAL_ENV_PROMPT
fi

# 1Password SSH agent (used for GitHub auth + git commit signing)
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# ----- Secrets -----
[ -f ~/.env ] && source ~/.env

# ----- Antidote -----
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load ~/.dotfiles/zsh/.zsh_plugins.txt

# ----- Modern CLI tools -----
eval "$(zoxide init zsh)"              # smarter cd (use 'z' command)
eval "$(fzf --zsh)"                    # fuzzy finder keybindings

# ----- mise (tool version manager + uv venv auto-activate) -----
# Owns Node (.nvmrc), Go, and Python — cwd-aware PATH for all managed tools —
# and sources uv-created .venv directories automatically
# (python.uv_venv_auto=source in mise config).
eval "$(mise activate zsh)"

# ----- Aliases -----

# Editors
alias vi=nvim
alias vim=nvim

# File listing (eza = modern ls replacement)
alias l="eza -l"                       # long format
alias la="eza -la"                     # long format + hidden
alias ls="eza"
alias tree="eza --tree"

# File viewing (bat = cat with syntax highlighting)
alias cat="bat --paging=never"

# Git
alias lg="lazygit"                     # git TUI

# Shell maintenance
alias antidote-update='antidote bundle < ~/.dotfiles/zsh/.zsh_plugins.txt > ~/.dotfiles/zsh/.zsh_plugins.zsh && source ~/.zshrc'

# Claude Code local OTel monitoring (Grafana LGTM via Podman) — see SETUP.md
# Grafana on 43000 (not 3000, avoids the usual dev-server collisions), fronted
# by caddy at http://ccdash.lvh.me:8080 (see caddy/Caddyfile).
alias ccdash-start='(podman start otel-lgtm 2>/dev/null || podman run -d --name otel-lgtm --restart=always -p 43000:3000 -p 4317:4317 -p 4318:4318 -v otel-lgtm-data:/data grafana/otel-lgtm) && echo "Grafana: http://ccdash.lvh.me:8080"'
alias ccdash-stop='podman stop otel-lgtm'

# ----- Starship prompt -----
export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml
eval "$(starship init zsh)"
