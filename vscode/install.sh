#!/bin/bash
set -ex

# create symlinks
ln -sfv "${HOME}"/dotfiles/vscode/settings.json "${HOME}"/Library/Application\ Support/Code/User

# sort settings.json
UUID=$(uuidgen)
jq --sort-keys < "${HOME}"/dotfiles/vscode/settings.json > /tmp/"${UUID}"
mv /tmp/"${UUID}" "${HOME}"/dotfiles/vscode/settings.json

# update extensions
code --update-extensions
