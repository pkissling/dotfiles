#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

# install brew, if not installed
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# update brew
brew update

# upgrade packages installed via brew
brew upgrade

# install packages from Brewfile
brew bundle --file "${HOME}"/dotfiles/brew/Brewfile."${USAGE}"

# create two temp files to compare delta
cat "${HOME}"/dotfiles/brew/Brewfile > /tmp/Brewfile.concat && cat "${HOME}"/dotfiles/brew/Brewfile."${USAGE}" >> /tmp/Brewfile.concat
brew bundle dump --file /tmp/Brewfile.dump --force

# identify delta (missing packages) and append to Brewfile
grep --invert-match --file /tmp/Brewfile.concat /tmp/Brewfile.dump >> "${HOME}"/dotfiles/brew/Brewfile."${USAGE}" || true

# sort Brewfiles
find "${HOME}"/dotfiles/brew -type f -name "Brewfile*" ! -name "*.lock.json" -exec sort {} -o {} \;
