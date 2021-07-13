#!/usr/bin/env bash

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install Bash 4
brew install bash

PACKAGES=(
  fd
  gawk
  git
  hub
  lazygit
  npm
  python
  python3
  reattach-to-user-namespace
  ripgrep
  tmux
  tree
  vim
  wget
  yarn
  zsh
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask

CASKS=(
  gpg-suite
  iterm2
  spotify
  tunnelblick
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}


echo "Installing fonts..."

brew tap homebrew/cask-fonts

FONTS=(
    font-clear-sans
    font-hack-nerd-font
    font-roboto
)
brew cask install ${FONTS[@]}

echo "Installing global npm packages..."
# npm install marked -g

echo "Configuring OSX..."

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "Creating folder structure..."
[[ ! -d Projects ]] && mkdir Projects
[[ ! -d Notes ]] && mkdir Notes

echo "Verifying "

brew doctor
brew missing

echo "Bootstrapping complete"

