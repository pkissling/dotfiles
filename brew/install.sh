#!/usr/bin/env bash

BASEDIR=$(dirname $0)

# install brew
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# update brew
brew update
brew upgrade

# install packages
while read PACKAGE
do
    brew list "${PACKAGE}" || brew install "${PACKAGE}"
done < "${BASEDIR}"/packages.txt

# cleanup
brew cleanup
