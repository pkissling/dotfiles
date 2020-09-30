#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")

# update
brew upgrade --cask

# install packages
sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' "${BASEDIR}/packages.txt" |
    while read -r PACKAGE
    do
        brew list --cask "${PACKAGE}" || brew cask install "${PACKAGE}"
    done

# cleanup
brew cleanup

# sort packages.txt file
UUID=$(uuidgen)
sort "${BASEDIR}"/packages.txt > /tmp/"${UUID}"
mv /tmp/"${UUID}" "${BASEDIR}"/packages.txt
