
alias l="ls -l ${colorflag}"
alias la="ls -la ${colorflag}"
alias whois="whois -h whois-servers.net"

# alias yarn-linked="find . -type l | grep -v .bin | sed 's/^\.\/node_modules\///'"
# alias yarn-unlink-all="yarn-linked | xargs yarn unlink && yarn install --check-files"

alias vi="lvim"
alias vim="lvim"

alias :q="exit"

export EDITOR=vi
export TERM=xterm-256color

export NVM_AUTO_USE=true
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=false

export ZSH=$HOME/.oh-my-zsh
export ZSH_TMUX_AUTOQUIT=false
export ZSH_TMUX_AUTOSTART=false

export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

gpgconf --launch gpg-agent
gpg-connect-agent /bye

export PATH=$PATH:./node_modules/.bin:~/.local/bin

[ -f ~/.dotfiles/aliases/aws ] && source ~/.dotfiles/aliases/aws
[ -f ~/.secrets ] && source ~/.secrets

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

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

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export PNPM_HOME="/Users/dane/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# NOTE: just using the starship defaults for now
# export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml
eval "$(starship init zsh)"

export PATH=~/.npm-global/bin:$PATH


. "$HOME/.langflow/uv/env"
export PATH="$HOME/.local/bin:$PATH"

# Neovim as default editor
export EDITOR=nvim
export VISUAL=nvim

# Neovim aliases
alias vim=nvim
alias vi=nvim
