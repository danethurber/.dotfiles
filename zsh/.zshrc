alias l="ls -l ${colorflag}"
alias la="ls -la ${colorflag}"
alias vi="nvim"
alias vim="nvim"
alias whois="whois -h whois-servers.net"

alias yarn-linked="find . -type l | grep -v .bin | sed 's/^\.\/node_modules\///'"
alias yarn-unlink-all="yarn-linked | xargs yarn unlink && yarn install --check-files"

alias :q="exit"

export EDITOR=nvim
export NVM_AUTO_USE=true
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=false
export TERM=xterm-256color
export ZSH=$HOME/.oh-my-zsh
export ZSH_TMUX_AUTOQUIT=false
export ZSH_TMUX_AUTOSTART=true

export PATH=$PATH:./node_modules/.bin

[ -f ~/.secrets ] && source ~/.secrets

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  tmux
  zsh-nvm

  colored-man-pages
  docker
  dotenv
  git
  kubectl
  npm
  yarn
)

source $ZSH/oh-my-zsh.sh

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml
eval "$(starship init zsh)"
