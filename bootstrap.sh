#!/usr/bin/env bash
set -e

echo "==> Bootstrapping dotfiles..."

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install packages from Brewfile
echo "==> Installing packages from Brewfile..."
brew bundle --file=~/.dotfiles/Brewfile

# Create directories
echo "==> Creating directories..."
mkdir -p ~/.config ~/Projects

# Create symlinks
echo "==> Creating symlinks..."
mkdir -p ~/Library/LaunchAgents
ln -sfn ~/.dotfiles/launchd/org.gnupg.gpg-agent.plist ~/Library/LaunchAgents/org.gnupg.gpg-agent.plist
ln -sfn ~/.dotfiles/nvim ~/.config/nvim
ln -sfn ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sfn ~/.dotfiles/.gitconfig ~/.gitconfig.local
ln -sfn ~/.dotfiles/.editorconfig ~/.editorconfig
mkdir -p ~/.claude
ln -sfn ~/.dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sfn ~/.dotfiles/claude/settings.json ~/.claude/settings.json

# Configure git to include our config
git config --global include.path "~/.gitconfig.local"
git config --global user.name "Dane Thurber"
git config --global user.email "dane.thurber@gmail.com"

# Regenerate antidote plugins (static file for faster shell startup)
echo "==> Regenerating antidote plugins..."
zsh -c 'source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh && antidote bundle < ~/.dotfiles/zsh/.zsh_plugins.txt > ~/.dotfiles/zsh/.zsh_plugins.zsh'

echo "==> Done! Open a new terminal to use the new config."
