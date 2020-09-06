#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# update
brew cask upgrade

# taps
brew tap homebrew/cask-fonts

# install packages
sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' "${BASEDIR}/packages.txt" |
    while read -r PACKAGE
    do
        brew cask list "${PACKAGE}" || brew cask install "${PACKAGE}"
    done

# cleanup
brew cleanup
