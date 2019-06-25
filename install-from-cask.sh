#!/bin/sh

brew tap caskroom/cask
brew tap caskroom/versions

packages=(
  'alacritty'
  'gpg-suite'
  'iterm2'
  'spotify'
  'tunnelblick'
)

for pkg in "${packages[@]}"
do
  echo "Installing" ${pkg}
  brew cask install $pkg  2> /dev/null
done
