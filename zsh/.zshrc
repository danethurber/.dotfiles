alias l="ls -l ${colorflag}"
alias la="ls -la ${colorflag}"
alias whois="whois -h whois-servers.net"

# alias yarn-linked="find . -type l | grep -v .bin | sed 's/^\.\/node_modules\///'"
# alias yarn-unlink-all="yarn-linked | xargs yarn unlink && yarn install --check-files"

alias :q="exit"
export TERM=xterm-256color

export NVM_AUTO_USE=true
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=true

export ZSH=$HOME/.oh-my-zsh
export ZSH_TMUX_AUTOQUIT=false
export ZSH_TMUX_AUTOSTART=false

export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# Launch GPG agent asynchronously to avoid blocking startup
(gpgconf --launch gpg-agent && gpg-connect-agent /bye) &>/dev/null &!

# Consolidate all PATH additions
export PATH="$PYENV_ROOT/bin:./node_modules/.bin:$HOME/.local/bin:$HOME/.npm-global/bin:/opt/homebrew/opt/libpq/bin:$PNPM_HOME:$PATH"

[ -f ~/.dotfiles/aliases/aws ] && source ~/.dotfiles/aliases/aws
[ -f ~/.secrets ] && source ~/.secrets

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Enable lazy loading for NVM (loads only when needed)
zstyle ':omz:plugins:nvm' lazy yes

plugins=(
  aws
  docker
  git
  zsh-nvm

  # colored-man-pages
  # dotenv
  # kubectl
  # npm
  # tmux
  # yarn
)

source $ZSH/oh-my-zsh.sh

# source ~/.bash_profile

# NVM is now lazy loaded via zsh-nvm plugin above, so these lines are not needed
# export NVM_DIR="$HOME/.nvm"
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Lazy load pyenv - only initialize when python/pip commands are used
export PYENV_ROOT="$HOME/.pyenv"
export PNPM_HOME="/Users/dane/Library/pnpm"

pyenv() {
  unset -f pyenv
  eval "$(command pyenv init -)"
  pyenv "$@"
}

# Neovim as default editor
export EDITOR=nvim
export VISUAL=nvim

# Neovim aliases
alias vim=nvim
alias vi=nvim

# Use custom Starship configuration
export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml
eval "$(starship init zsh)"
