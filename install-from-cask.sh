#!/bin/sh

brew tap caskroom/cask
brew tap caskroom/versions

packages=(
  'gpg-suite'
  'iterm2'
  'sketch'
  'spotify'
  'tunnelblick'
  'visual-studio-code'
)

for pkg in "${packages[@]}"
do
  echo "Installing" ${pkg}
  brew cask install $pkg  2> /dev/null
done
