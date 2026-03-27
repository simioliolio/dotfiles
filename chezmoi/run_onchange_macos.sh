#!/usr/bin/env bash

echo "Applying macOS system preferences..."

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# ------------------------------------------------------------------------------
# Google Chrome
# ------------------------------------------------------------------------------
echo "Setting Chrome custom keyboard shortcuts..."
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add "Move Tab to New Window" "^~@t"

# ------------------------------------------------------------------------------
# Dock
# ------------------------------------------------------------------------------
echo "Enabling Dock autohide..."
defaults write com.apple.dock autohide -bool true

# ------------------------------------------------------------------------------
# Keyboard (NSGlobalDomain)
# ------------------------------------------------------------------------------
echo "Setting keyboard repeat rates and UI mode..."
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 10
# Enable full keyboard access for all controls (e.g., enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# ------------------------------------------------------------------------------
# Trackpad
# ------------------------------------------------------------------------------
echo "Configuring trackpad settings..."
# Disable force click
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false
# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# Enable three-finger drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# ------------------------------------------------------------------------------
# Accessibility
# ------------------------------------------------------------------------------
echo "Configuring accessibility settings..."
# Use scroll wheel with modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
# Reduce motion
defaults write com.apple.universalaccess reduceMotion -bool true
defaults write com.apple.Accessibility reduceMotion -bool true

# ------------------------------------------------------------------------------
# Keyboard Shortcuts
# ------------------------------------------------------------------------------
echo "Disabling Game Overlay shortcut (Cmd+Esc)..."
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 260 '
  <dict>
    <key>enabled</key><false/>
    <key>value</key>
    <dict>
      <key>parameters</key>
      <array>
        <integer>65535</integer>
        <integer>53</integer>
        <integer>1048576</integer>
      </array>
      <key>type</key><string>standard</string>
    </dict>
  </dict>'

# ------------------------------------------------------------------------------
# Restart affected applications
# ------------------------------------------------------------------------------
echo "Restarting affected apps to apply changes..."
killall Dock
# killall Finder (if adding Finder tweaks later)

echo "Done! Note: Some changes may require a logout/restart to take full effect."
