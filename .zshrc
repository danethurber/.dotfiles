export ZSH=$HOME/.oh-my-zsh

export NVM_LAZY_LOAD=false
export NVM_AUTO_USE=true

ZSH_THEME="cloud"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(zsh-nvm brew git github git-extras)

source $ZSH/oh-my-zsh.sh

# export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$PATH

export PATH=$PATH:./node_modules/.bin

# alias sudo='sudo '
# alias fore="foreman start"
# alias be="bundle exec "

alias l="ls -l ${colorflag}"
alias la="ls -la ${colorflag}"
alias whois="whois -h whois-servers.net"

[ -f ~/.secrets ] && source ~/.secrets

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

