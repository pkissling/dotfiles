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

# dump all installed extensions in extensions.txt
ls -l "${HOME}"/.vscode/extensions |\
  # discard first line, only keep folder name
  awk '{ if(NR>1) print $9 }' |\
  # remove version from folder name
  sed 's/-[0-9].*//' \
  > "${BASEDIR}"/extensions.txt
