#!/usr/bin/env bash

step_count=0

highlight=$(tput setaf 4)
text=$(tput sgr0)

log () {
  printf "[$2] ${highlight}$1 ${text}\n"
}

# ---
log "Bootstrapping" "!"

# ---
step_count=$[$step_count+1]
log "Updating Homebrew..." $step_count

if test ! $(which brew); then
  echo Installing homebrew...
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/dane/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update --quiet
brew upgrade --quiet

# ---
step_count=$[$step_count+1]
log "Installing Packages..." $step_count

PACKAGES=(
  awscli
  git
  gnupg
  gnupg2
  jq
  neovim
  nvm
  pyenv
  python
  starship
  tmux
)

for item in "${PACKAGES[@]}"; do
  brew info "${item}" | grep --quiet 'Not installed' && brew install "${item}"
done


# ---
step_count=$[$step_count+1]
log "Installing Fonts..." $step_count

FONTS=(
  font-hack-nerd-font
)

brew tap homebrew/cask-fonts

for item in "${FONTS[@]}"; do
  brew info "${item}" | grep --quiet 'Not installed' && brew install --cask "${item}"
done

# ---
step_count=$[$step_count+1]
log "Verifying Homebrew..." $step_count

brew cleanup --quiet
brew missing --quiet

# ---
step_count=$[$step_count+1]
log "Configuring Git..." $step_count

git config --global include.path "~/.dotfiles/.gitconfig"
git config --global user.name "Dane Thurber"
git config --global user.email "dane.thurber@gmail.com"

# ---
step_count=$[$step_count+1]
log "Creating User Folders/Files..." $step_count

[[ ! -d ~/Notes ]] && mkdir ~/Notes
[[ ! -d ~/Playground ]] && mkdir ~/Playground
[[ ! -d ~/Projects ]] && mkdir ~/Projects

[[ ! -d ~/.config ]] && mkdir ~/.config
[[ ! -d ~/.nvm ]] && mkdir ~/.nvm
[[ ! -d ~/.secrets ]] && mkdir ~/.secrets

# ---
step_count=$[$step_count+1]
log "Installing ohmyzsh" $step_count
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ---
step_count=$[$step_count+1]
log "Symlinking Config Files..." $step_count

[[ ! -d ~/.config/nvim ]] && ln -nfs ~/.dotfiles/nvim ~/.config/nvim
[[ ! -d ~/.config/starship.toml ]] && ln -nfs ~/.dotfiles/starship.tom ~/.config/starship.toml
[[ ! -d ~/.psqlrc ]] && ln -nfs ~/.dotfiles/.psqlrc ~/.psqlrc
[[ ! -d ~/.editorconfig ]] && ln -nfs ~/.dotfiles/.editorconfig ~/.editorconfig
[[ ! -d ~/.tmux.conf ]] && ln -nfs ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
[[ ! -d ~/.zshrc ]] && ln -nfs ~/.dotfiles/zsh/.zshrc ~/.zshrc

# ---
step_count=$[$step_count+1]
log "Installing Node" $step_count
nvm install node

# ---
if test ! $(which cargo); then
  step_count=$[$step_count+1]
  log "Installing Rust" $step_count
  curl https://sh.rustup.rs -sSf | sh

fi

# ---
log "Bootstrapping Completed! \n" "!"

