#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$0")

# create symlinks
ln -sfv "${PWD}"/"${BASEDIR}"/keybindings.json "${HOME}"/Library/Application\ Support/Code/User
ln -sfv "${PWD}"/"${BASEDIR}"/settings.json "${HOME}"/Library/Application\ Support/Code/User

# compare list of installed extensions with extensions.txt and identify delta
MISSING_EXTENSIONS=$(code --list-extensions | grep --ignore-case --invert-match --file /dev/stdin vscode/extensions.txt) || true
for MISSING_EXTENSION in ${MISSING_EXTENSIONS}; do
    code --install-extension "${MISSING_EXTENSION}"
done

# shellcheck disable=SC2012
ls -l "${HOME}"/.vscode/extensions |\
  # discard first line, only keep folder name
  awk '{ if(NR>1) print $9 }' |\
  # remove version from folder name
  sed 's/-[0-9].*//' |\
  # sometimes multipe version of the plugin are installed in parallel
  uniq \
  > "${BASEDIR}"/extensions.txt
