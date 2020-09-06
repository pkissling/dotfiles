#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# install brew, if not installed
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# update brew
brew update
brew upgrade

# install packages
sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' "${BASEDIR}/packages.txt" |
    while read -r PACKAGE
    do
        brew list "${PACKAGE}" || brew install "${PACKAGE}"
    done

# cleanup
brew cleanup
