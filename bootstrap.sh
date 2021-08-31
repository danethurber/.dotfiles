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
fi

brew update --quiet
brew upgrade --quiet

# ---
step_count=$[$step_count+1]
log "Installing Packages..." $step_count

PACKAGES=(
  git
  neovim
  nvm
  starship
  tmux
  visual-studio-code
)

for item in "${PACKAGES[@]}"; do
  brew info "${item}" | grep --quiet 'Not installed' && brew install "${item}"
done

# ---
step_count=$[$step_count+1]
log "Installing Casks..." $step_count

CASKS=(
  gpg-suite
  iterm2
  spotify
  tunnelblick
)

for item in "${CASKS[@]}"; do
  brew info "${item}" | grep --quiet 'Not installed' && brew install --cask "${item}"
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
log "Configuring OSX..." $step_count

# # Set fast key repeat rate
# defaults write NSGlobalDomain KeyRepeat -int 0

# # Require password as soon as screensaver or sleep mode starts
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

# # Show filename extensions by default
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# # Enable tap-to-click
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# # Disable "natural" scroll
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

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
log "Symlinking Config Files..." $step_count

[[ ! -d ~/.config/nvim/init.lua ]] && ln -nfs ~/.dotfiles/neovim/init.lua ~/.config/nvim/init.lua
[[ ! -d ~/.config/starship.toml ]] && ln -nfs ~/.dotfiles/starship.tom ~/.config/starship.toml
[[ ! -d ~/.editorconfig ]] && ln -nfs ~/.dotfiles/.editorconfig ~/.editorconfig
~/prettier.config.js
[[ ! -d ~/.psqlrc ]] && ln -nfs ~/.dotfiles/.psqlrc ~/.psqlrc
[[ ! -d ~/.tmux.conf ]] && ln -nfs ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
[[ ! -d ~/.vimrc ]] && ln -nfs ~/.dotfiles/vim/.vimrc ~/.vimrc
[[ ! -d ~/.zshrc ]] && ln -nfs ~/.dotfiles/zsh/.zshrc ~/.zshrc
[[ ! -d ~/coc-settings.json ]] && ln -nfs ~/.dotfiles/coc-settings.json ~/coc-settings.json

# ---
log "Bootstrapping Completed! \n" "!"
