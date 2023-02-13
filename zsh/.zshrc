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
export ZSH_TMUX_AUTOSTART=false

export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

gpgconf --launch gpg-agent
gpg-connect-agent /bye

export PATH=$PATH:./node_modules/.bin:~/.local/bin

[ -f ~/.secrets ] && source ~/.secrets

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  tmux

  aws
  colored-man-pages
  docker
  dotenv
  git
  kubectl
  npm
  yarn
  zsh-nvm
)

source $ZSH/oh-my-zsh.sh
# source ~/.bash_profile

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml
eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

