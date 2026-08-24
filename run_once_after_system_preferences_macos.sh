#!/bin/bash

echo "Updating system preferences"

### Appearance ###

# Follow the system schedule to switch between light and dark appearance
defaults write NSGlobalDomain "AppleInterfaceStyleSwitchesAutomatically" -bool "true"

# Do not tint window backgrounds with the desktop wallpaper colors
defaults write NSGlobalDomain "AppleReduceDesktopTinting" -bool "true"

# Only show scroll bars when scrolling
defaults write NSGlobalDomain "AppleShowScrollBars" -string "WhenScrolling"

# Jump to the clicked spot in the scroll bar instead of the next page
defaults write NSGlobalDomain "AppleScrollerPagingBehavior" -bool "true"

### Menu bar ###

# Use a 24-hour clock
defaults write NSGlobalDomain "AppleICUForce24HourTime" -bool "true"

# Show seconds, and hide the date and the day of the week, in the clock
defaults write com.apple.menuextra.clock "ShowSeconds" -bool "true"
defaults write com.apple.menuextra.clock "ShowDate" -int 2
defaults write com.apple.menuextra.clock "ShowDayOfWeek" -bool "false"

### Desktop & Dock ###

# Do not display recent apps in the Dock
defaults write com.apple.dock "show-recents" -bool "false"

# Autohide the Dock when the mouse is out
defaults write com.apple.dock "autohide" -bool "true"

# Remove the Dock autohide delay, so the Dock appears instantly
defaults write com.apple.dock "autohide-delay" -int 0
defaults write com.apple.dock "autohide-time-modifier" -float 0.25

# Set the Dock icon size
defaults write com.apple.dock "tilesize" -float 55

# Minimize windows into their application icon
defaults write com.apple.dock "minimize-to-application" -bool "true"

# Group Mission Control windows by application
defaults write com.apple.dock "expose-group-apps" -bool "true"

# Enable the App Exposé trackpad gesture
defaults write com.apple.dock "showAppExposeGestureEnabled" -bool "true"

# Do not reorder Spaces based on use
defaults write com.apple.dock "mru-spaces" -bool "false"

# Assign no action to any of the hot corners
for corner in "tl" "tr" "bl" "br"; do
  defaults write com.apple.dock "wvous-${corner}-corner" -int 0
  defaults write com.apple.dock "wvous-${corner}-modifier" -int 0
done

# Do not tile windows by dragging them to the screen edges
defaults write com.apple.WindowManager "EnableTilingByEdgeDrag" -bool "false"
defaults write com.apple.WindowManager "EnableTopTilingByEdgeDrag" -bool "false"

# Do not leave a margin between tiled windows
defaults write com.apple.WindowManager "EnableTiledWindowMargins" -bool "false"

### Finder ###

# Show all file extensions in the Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Do not warn when changing a file extension
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

# Show path bar in the bottom of the Finder windows
defaults write com.apple.finder "ShowPathbar" -bool "true"

# Keep folders on top when sorting by name
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Set List as the default view style for folders without custom setting
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# Open new Finder windows in the home folder
defaults write com.apple.finder "NewWindowTarget" -string "PfHm"

# Search the current folder by default
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

# Remove items from the Trash after 30 days
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"

# Do not write .DS_Store files on network and USB volumes
defaults write com.apple.desktopservices "DSDontWriteNetworkStores" -bool "true"
defaults write com.apple.desktopservices "DSDontWriteUSBStores" -bool "true"

### Keyboard ###

# Set key repeat rate to 1 (fast) and initial key repeat delay to 10 (short)
defaults write NSGlobalDomain "KeyRepeat" -int 1
defaults write NSGlobalDomain "InitialKeyRepeat" -int 10

# Set Fn/🌐 key to do nothing
defaults write com.apple.HIToolbox AppleFnUsageType -int 0

# Free up system shortcuts that either conflict with other tools or are unused:
# - 28-31 screenshot capture (⇧+⌘+3 | ⌃+⇧+⌘+3 | ⇧+⌘+4 | ⌃+⇧+⌘+4)
# - 60-61 input source switching (⌃+Space | ⌃+⌥+Space)
# - 65 Finder search window (⌥+⌘+Space)
# - 164 Quick Note (🌐+Q)
# - 176 emoji picker (⌃+⌘+Space)
for hotkey in 28 29 30 31 60 61 65 164 176; do
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "${hotkey}" \
    "<dict><key>enabled</key><false/></dict>"
done

### Trackpad & mouse ###

# Tap to click
defaults write com.apple.AppleMultitouchTrackpad "Clicking" -bool "true"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "Clicking" -bool "true"

# Set trackpad weight to light
defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int 0
defaults write com.apple.AppleMultitouchTrackpad "SecondClickThreshold" -int 0

# Set a fast trackpad tracking speed
defaults write NSGlobalDomain "com.apple.trackpad.scaling" -float 2

# Scroll in the same direction as the content moves
defaults write NSGlobalDomain "com.apple.swipescrolldirection" -bool "false"

# Set a slow mouse tracking speed, without acceleration
defaults write NSGlobalDomain "com.apple.mouse.scaling" -float 1
defaults write NSGlobalDomain "com.apple.mouse.linear" -bool "true"

### Screenshots ###

# Set default location for screenshots
defaults write com.apple.screencapture "location" -string "~/Downloads"

### Developer tools ###

# Show the build duration in the Xcode's toolbar
defaults write com.apple.dt.Xcode "ShowBuildOperationDuration" -bool "true"

# Hide the Xcode minimap and code folding ribbon
defaults write com.apple.dt.Xcode "DVTTextShowMinimap" -bool "false"
defaults write com.apple.dt.Xcode "DVTTextShowFoldingSidebar" -bool "false"

# Show a page guide at column 120 in the Xcode editor
defaults write com.apple.dt.Xcode "DVTTextShowPageGuide" -bool "true"
defaults write com.apple.dt.Xcode "DVTTextPageGuideLocation" -int 120

# Set default location for Simulator screenshots
defaults write com.apple.iphonesimulator "ScreenShotSaveLocation" -string "~/Downloads"

# Show single touches in the Simulator
defaults write com.apple.iphonesimulator "ShowSingleTouches" -bool "true"

### Apply ###

# Reload the keyboard shortcuts without logging out
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

for app in "ControlCenter" "Dock" "Finder" "SystemUIServer" "Xcode"; do
  killall "${app}" >/dev/null 2>&1
done

echo "System preferences updated successfully"
