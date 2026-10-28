#!/bin/bash
set -ex

# create symlinks
ln -sfv "${HOME}"/dotfiles/vscode/settings.json "${HOME}"/Library/Application\ Support/Code/User

# sort settings.json
TMP=$(mktemp)
jq --sort-keys < "${HOME}"/dotfiles/vscode/settings.json > "${TMP}"
mv "${TMP}" "${HOME}"/dotfiles/vscode/settings.json

# update extensions
code --update-extensions

# Allow vim key repeat
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.jetbrains.intellij ApplePressAndHoldEnabled -bool false
defaults write -g ApplePressAndHoldEnabled -bool false
