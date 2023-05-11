#!/usr/bin/env bash
set -ex

# create symlinks
ln -sfv "${HOME}"/dotfiles/vscode/settings.json "${HOME}"/Library/Application\ Support/Code/User

# compare list of installed extensions with extensions.txt and identify delta
MISSING_EXTENSIONS=$(code --list-extensions | grep --ignore-case --invert-match --file /dev/stdin vscode/extensions.txt) || true
for MISSING_EXTENSION in ${MISSING_EXTENSIONS}; do
    code --install-extension "${MISSING_EXTENSION}"
done
code --list-extensions > "${HOME}"/dotfiles/vscode/extensions.txt

# sort settings.json
UUID=$(uuidgen)
jq --sort-keys < "${HOME}"/dotfiles/vscode/settings.json > /tmp/"${UUID}"
mv /tmp/"${UUID}" "${HOME}"/dotfiles/vscode/settings.json
