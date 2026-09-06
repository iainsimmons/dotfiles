# Hide the dock completely
# Use Cmd + Opt + D to toggle show/hide if necessary
defaults write com.apple.dock autohide-delay -float 1000
killall Dock

# Disable press and hold to show accented characters
defaults write -g ApplePressAndHoldEnabled -bool false
