#!/usr/bin/env bash

if test ! $(which brew); then
  echo Installing homebrew...
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo Updating homebrew...

brew update
brew upgrade

PACKAGES=(
  git
  nvm
  starship
  tmux
  vim
  visual-studio-code
  zoom
)

for item in "${PACKAGES[@]}"; do
  brew info "${item}" | grep --quiet 'Not installed' && brew install "${item}"
done

CASKS=(
  gpg-suite iterm2
  spotify
  tunnelblick
)

for item in "${CASKS[@]}"; do
  brew info "${item}" | grep --quiet 'Not installed' && brew install --cask "${item}"
done

FONTS=(
  font-hack-nerd-font
)

brew tap homebrew/cask-fonts

for item in "${FONTS[@]}"; do
  brew info "${item}" | grep --quiet 'Not installed' && brew install --cask "${item}"
done


echo Verifying Homebrew

brew cleanup
brew doctor
brew missing

# echo Installing on-my-zsh...
# /bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo Configuring Git

git config --global include.path "~/.dotfiles/.gitconfig"
git config --global user.name "Dane Thurber"
git config --global user.email "dane.thurber@gmail.com"

echo Creating User Folders/Files

[[ ! -d ~/.config ]] && mkdir ~/.config
[[ ! -d ~/.nvm ]] && mkdir ~/.nvm
[[ ! -d ~/Notes ]] && mkdir ~/Notes
[[ ! -d ~/Playground ]] && mkdir ~/Playground
[[ ! -d ~/Projects ]] && mkdir ~/Projects

[[ ! -d ~/.secrets ]] && mkdir ~/.secrets

echo Symlinking config files

[[ ! -d ~/.editorconfig ]] && ln -s ~/.dotfiles/.editorconfig ~/.editorconfig
[[ ! -d ~/.psqlrc ]] && ln -s ~/.dotfiles/.psqlrc ~/.psqlrc
[[ ! -d ~/.tmux.conf ]] && ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
[[ ! -d ~/.config/starship.toml ]] && ln -s ~/.dotfiles/starship.tom ~/.config/starship.toml
[[ ! -d ~/.vimrc ]] && ln -s ~/.dotfiles/.vimrc ~/.vimrc
[[ ! -d ~/.zshrc ]] && ln -s ~/.dotfiles/.zshrc ~/.zshrc
[[ ! -d ~/coc-settings.json ]] && ln -s ~/.dotfiles/coc-settings.json ~/coc-settings.json

echo Bootstrapping Completed!
