#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# update
brew cask upgrade

# taps
brew tap homebrew/cask-fonts

# install packages
while read -r PACKAGE
do
    brew cask list "${PACKAGE}" || brew cask install "${PACKAGE}"
done < "${BASEDIR}"/packages.txt

# cleanup
brew cleanup
