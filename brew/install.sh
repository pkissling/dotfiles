#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$0")

# install brew, if not installed
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install packages from Brewfile
brew bundle --file "${BASEDIR}"/Brewfile

# cleanup
brew cleanup

# update Brewfile
brew bundle dump --file "${BASEDIR}"/Brewfile --force
