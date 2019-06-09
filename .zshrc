export ZSH=$HOME/.oh-my-zsh

export NVM_LAZY_LOAD=false
export NVM_AUTO_USE=true

ZSH_THEME="cloud"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(zsh-nvm brew git github git-extras)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:./node_modules/.bin
export PATH=/usr/local/opt/python/libexec/bin:$PATH

alias l="ls -l ${colorflag}"
alias la="ls -la ${colorflag}"
alias whois="whois -h whois-servers.net"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

stty -ixon

[ -f ~/.secrets ] && source ~/.secrets
export PATH="/usr/local/opt/ruby/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
