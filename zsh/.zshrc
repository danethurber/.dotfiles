alias l="ls -l ${colorflag}"
alias la="ls -la ${colorflag}"
alias whois="whois -h whois-servers.net"
# alias yarn-linked="find . -type l | grep -v .bin | sed 's/^\.\/node_modules\///'"

# alias yarn-unlink-all="yarn-linked | xargs yarn unlink && yarn install --check-files"

alias vi="lvim"
alias vim="lvim"

alias :q="exit"

export EDITOR=vi
export NVM_AUTO_USE=true
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=false
export TERM=xterm-256color
export ZSH=$HOME/.oh-my-zsh
export ZSH_TMUX_AUTOQUIT=false
export ZSH_TMUX_AUTOSTART=true

export GPG_TTY=$(tty)

export PATH=$PATH:
export PATH=$PATH:./node_modules/.bin:~/.local/bin

[ -f ~/.secrets ] && source ~/.secrets

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  tmux

  colored-man-pages
  docker
  dotenv
  git
  kubectl
  npm
  yarn
)

# source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml
eval "$(starship init zsh)"
