#!/usr/bin/env zsh

# Show all file extensions in the Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Show path bar in the bottom of the Finder windows
defaults write com.apple.finder "ShowPathbar" -bool "true"

# Keep folders on top when sorting by name
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Set List as the default view style for folders without custom setting
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# Only show scroll bars when scrolling
defaults write NSGlobalDomain "AppleShowScrollBars" -string "WhenScrolling"

# Do not display recent apps in the Dock
defaults write com.apple.dock "show-recents" -bool "false"

# Autohide the Dock when the mouse is out
defaults write com.apple.dock "autohide" -bool "true"

# Remove the Dock autohide delay, so the Dock appears instantly
defaults write com.apple.dock "autohide-delay" -float "0"

# Do not reorder Spaces based on use
defaults write com.apple.dock "mru-spaces" -bool "false"

# Set default location for screenshots
defaults write com.apple.screencapture "location" -string "~/Downloads"

# Set default location for Simulator screenshots
defaults write com.apple.iphonesimulator "ScreenShotSaveLocation" -string "~/Downloads"

# Set trackpad weight to light
defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int "0"

# Show the build duration in the Xcode's toolbar
defaults write com.apple.dt.Xcode "ShowBuildOperationDuration" -bool "true"

for app in "Dock" \ "Finder" \ "SystemUIServer" \ "Xcode"; do
  killall "${app}" >/dev/null 2>&1
done

echo "System preferences have been updated"
