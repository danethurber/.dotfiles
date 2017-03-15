#!/bin/sh

brew tap caskroom/cask
brew tap caskroom/versions

packages=(
  '1password'
  'atom'
  'caffeine'
  'day-o'
  'google-chrome'
  'iterm2'
  'java'
  'screenhero'
  'slack'
  'sketch'
  'spotify'
  'tunnelblick'
  'virtualbox'
  'visual-studio-code'
)

for pkg in "${packages[@]}"
do
  echo "Installing" ${pkg}
  brew cask install $pkg  2> /dev/null
done
