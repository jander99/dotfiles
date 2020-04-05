#!/bin/sh

# Dock Config

# Reset all Icons on Dock
defaults write com.apple.dock persistent-apps -array


# Add Chrome to Dock 
if [ -d /Applications/Google\ Chrome.app ]; then
    defaults write com.apple.dock persistent-apps -array-add ' <dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict> '
fi 

# Add iTerm to Dock
if [ -d /Applications/iTerm.app ]; then 
    defaults write com.apple.dock persistent-apps -array-add ' <dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict> '
fi

# Add Slack to Dock
if [ -d /Application/Slack.app ]; then
    defaults write com.apple.dock persistent-apps -array-add ' <dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Slack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict> '
fi 

# Add Microsoft Outlook to Dock
if [ -d /Applications/Microsoft\ Outlook.app ]; then 
    defaults write com.apple.dock persistent-apps -array-add ' <dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Microsoft Outlook.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict> '
fi

# Disable Recent Apps
defaults write com.apple.dock show-recents -bool false

# Restart Dock
killall Dock
