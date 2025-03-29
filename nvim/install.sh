#!/usr/bin/env bash
set -e

# create config folder, if not exist
mkdir -p "${HOME}"/.config

# create symlink
ln -sfv "${HOME}"/dotfiles/nvim/kickstart.nvim "${HOME}"/.config/nvim
