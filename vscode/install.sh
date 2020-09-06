#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# create symlinks
ln -sfv "${PWD}"/"${BASEDIR}"/keybindings.json "${HOME}"/Library/Application\ Support/Code/User
ln -sfv "${PWD}"/"${BASEDIR}"/settings.json "${HOME}"/Library/Application\ Support/Code/User

# install extensions
sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' "${BASEDIR}/extensions.txt" |
    while read -r EXTENSION
    do
        code --install-extension "$EXTENSION"
    done
