#!/usr/bin/env bash
set -ex

# install brew, if not installed
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install packages from Brewfile
brew bundle --file "${HOME}"/dotfiles/brew/Brewfile

# update Brewfile
brew bundle dump --file "${HOME}"/dotfiles/brew/Brewfile --force
