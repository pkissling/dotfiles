#!/usr/bin/env bash
set -e

# create config folder, if not exist
mkdir -p "${HOME}"/.config

# remove existing nvim directory/symlink
rm -rf "${HOME}/.config/nvim"

# create symlink
ln -sfv "${HOME}"/dotfiles/nvim/kickstart.nvim "${HOME}"/.config/nvim
