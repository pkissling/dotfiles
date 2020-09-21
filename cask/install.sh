#!/usr/bin/env bash

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
