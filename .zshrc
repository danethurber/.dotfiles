export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="cloud"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(brew git github git-extras bower atom sublime ruby rails heroku)

source $ZSH/oh-my-zsh.sh

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

alias sudo='sudo '
alias fore="foreman start"
alias be="bundle exec "

alias l="ls -l ${colorflag}"
alias la="ls -la ${colorflag}"
alias whois="whois -h whois-servers.net"

[ -f ~/.secrets ] && source ~/.secrets
