#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# update
brew upgrade --cask

# taps
brew tap homebrew/cask-fonts

# install packages
sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' "${BASEDIR}/packages.txt" |
    while read -r PACKAGE
    do
        brew list --cask "${PACKAGE}" || brew install cask "${PACKAGE}"
    done

# cleanup
brew cleanup
