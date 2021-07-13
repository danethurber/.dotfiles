export ZSH=$HOME/.oh-my-zsh

export EDITOR=vim
export TERM=xterm-256color

export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=false

export NVM_LAZY_LOAD=false
export NVM_AUTO_USE=true
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


# ZSH_THEME="cloud"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(zsh-nvm brew git github git-extras tmux kubectl)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:./node_modules/.bin

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

alias l="ls -l ${colorflag}"
alias la="ls -la ${colorflag}"
alias whois="whois -h whois-servers.net"
alias :q="exit"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

stty -ixon

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.secrets ] && source ~/.secrets

export STARSHIP_CONFIG=~/.dotfiles/starship.toml
eval "$(starship init zsh)"

