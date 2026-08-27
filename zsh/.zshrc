# ~/.zshrc - Minimal zsh config with Antidote

# ----- Environment -----
export EDITOR=nvim
export VISUAL=nvim
bindkey -e
unset GIT_EDITOR  # Prevent Cursor's remote-containers extension from overriding
export VIRTUAL_ENV_DISABLE_PROMPT=1  # Let starship handle venv display
export PNPM_HOME="$HOME/Library/pnpm"
export AWS_PAGER=''                  # AWS CLI v2 pipes everything through `less`

# PATH
# typeset -U keeps entries unique, first occurrence winning. Without it this
# unguarded prepend accumulates duplicates every time a nested shell re-sources
# this file — which is why $PATH used to list .local/bin twice.
typeset -U path PATH
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

# Local dev Grafana dashboard hub -> http://localdash.lvh.me:8080
alias localdash-start='(podman start otel-lgtm 2>/dev/null || podman run -d --name otel-lgtm --restart=always -p 43000:3000 -p 4317:4317 -p 4318:4318 -p 9090:9090 -v otel-lgtm-data:/data grafana/otel-lgtm) && echo "Grafana: http://localdash.lvh.me:8080"'
alias localdash-stop='podman stop otel-lgtm'

# ----- Starship prompt -----
export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml
eval "$(starship init zsh)"
