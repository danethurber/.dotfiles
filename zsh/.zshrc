# ~/.zshrc - Minimal zsh config with Antidote

# ----- Environment -----
export TERM=xterm-256color
export EDITOR=nvim
export VISUAL=nvim
bindkey -e
unset GIT_EDITOR  # Prevent Cursor's remote-containers extension from overriding
export VIRTUAL_ENV_DISABLE_PROMPT=1  # Let starship handle venv display
export PNPM_HOME="$HOME/Library/pnpm"

# PATH
export PATH="./node_modules/.bin:$HOME/.local/bin:$HOME/.npm-global/bin:/opt/homebrew/opt/libpq/bin:$PNPM_HOME:$PATH"

# GPG (agent started via launchd or on-demand)
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# ----- Secrets -----
[ -f ~/.env ] && source ~/.env

# ----- Antidote -----
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load ~/.dotfiles/zsh/.zsh_plugins.txt

# ----- fnm (Fast Node Manager) -----
eval "$(fnm env --use-on-cd)"

# ----- Modern CLI tools -----
eval "$(zoxide init zsh)"              # smarter cd (use 'z' command)
eval "$(fzf --zsh)"                    # fuzzy finder keybindings

# ----- Python venv auto-activate -----
# Find nearest .venv up the directory tree and activate with project name
auto_activate_venv() {
  local dir="$PWD"
  local venv_dir=""
  local project_name=""

  # Search up for .venv
  while [[ "$dir" != "/" ]]; do
    if [[ -d "$dir/.venv" ]]; then
      venv_dir="$dir/.venv"
      project_name="${dir:t}"
      break
    fi
    dir="${dir:h}"
  done

  if [[ -n "$venv_dir" ]]; then
    if [[ "$VIRTUAL_ENV" != "$venv_dir" ]]; then
      [[ -n "$VIRTUAL_ENV" ]] && deactivate
      source "$venv_dir/bin/activate"
      # Override VIRTUAL_ENV to show project name in starship
      export VIRTUAL_ENV="${venv_dir:h}/$project_name"
    fi
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    deactivate
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd auto_activate_venv
auto_activate_venv  # run on shell start

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

# ----- Starship prompt -----
export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml
eval "$(starship init zsh)"
