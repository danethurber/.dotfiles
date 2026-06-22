#!/usr/bin/env bash
# macOS system defaults — opt-in tweaks for a new machine.
# Review before running; not invoked automatically by bootstrap.sh.
# Re-runnable. Some changes require a logout/restart to take full effect.
set -euo pipefail

echo "==> Applying macOS defaults..."

# ----- Keyboard -----
# Fast key repeat (great for vim). KeyRepeat=2 is fast but controllable (1 = fastest).
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Disable press-and-hold for accent menu so key-repeat works in editors.
defaults write -g ApplePressAndHoldEnabled -bool false

# ----- Finder -----
defaults write com.apple.finder AppleShowAllFiles -bool true          # show hidden files
defaults write NSGlobalDomain AppleShowAllExtensions -bool true       # show file extensions
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# ----- Screenshots -----
mkdir -p "${HOME}/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"
defaults write com.apple.screencapture type -string "png"

# ----- Dock -----
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false

# ----- Misc -----
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "==> Restarting Finder and Dock..."
killall Finder Dock 2>/dev/null || true

echo "==> Done. Some changes need a logout/restart to fully apply."
