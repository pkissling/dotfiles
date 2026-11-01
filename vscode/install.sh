#!/bin/bash
set -ex

# sort settings.json
TMP=$(mktemp)
jq --sort-keys < "${HOME}"/dotfiles/vscode/settings.json > "${TMP}"
mv "${TMP}" "${HOME}"/dotfiles/vscode/settings.json

# update extensions
code --update-extensions
