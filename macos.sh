#!/bin/bash
# Sensible macOS defaults for a fresh machine.
# Safe to re-run. Some settings need a logout/restart to take full effect.
set -e

echo "Setting macOS defaults..."

# Close System Settings so it doesn't overwrite changes while we're working.
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# --- Trackpad / mouse ---
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1        # tap to click
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1.5     # tracking speed

# --- Keyboard ---
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false      # key repeat over accent picker

# --- Finder ---
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"     # list view
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# --- Dock ---
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 42

# --- Screenshots ---
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
defaults write com.apple.screencapture type -string "png"

# --- Safety / sanity ---
defaults write com.apple.LaunchServices LSQuarantine -bool true        # keep "are you sure you want to open this" for downloads

echo "Restarting affected apps..."
for app in "Finder" "Dock" "SystemUIServer"; do
  killall "$app" &>/dev/null || true
done

echo "macOS defaults applied."
