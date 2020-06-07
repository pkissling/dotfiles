#!/usr/bin/env bash

BASEDIR=$(dirname $0)

# create symlinks
ln -sfv "${PWD}"/"${BASEDIR}"/keybindings.json "${HOME}"/Library/Application\ Support/Code/User
ln -sfv "${PWD}"/"${BASEDIR}"/settings.json "${HOME}"/Library/Application\ Support/Code/User

# install extensions
while read EXTENSION
do
    code --install-extension $EXTENSION
done < "${BASEDIR}"/extensions.txt
