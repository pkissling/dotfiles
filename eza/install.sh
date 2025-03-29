#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/eza

# create symlinks
ln -sfv "${HOME}"/dotfiles/eza/themes/gruvbox-dark.yml "${HOME}"/.config/eza/theme.yml
