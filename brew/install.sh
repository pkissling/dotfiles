#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

# install brew, if not installed
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install packages from Brewfile
brew bundle --file "${HOME}"/dotfiles/brew/Brewfile."${USAGE}"

# create two temp files to compare delta
cat "${HOME}"/dotfiles/brew/Brewfile > /tmp/Brewfile.concat && sed -e '1,3d' < "${HOME}"/dotfiles/brew/Brewfile."${USAGE}" >> /tmp/Brewfile.concat
brew bundle dump --file /tmp/Brewfile.dump --force

# identify delta (missing packages) and append to Brewfile
grep --invert-match --file /tmp/Brewfile.concat /tmp/Brewfile.dump >> "${HOME}"/dotfiles/brew/Brewfile || true
