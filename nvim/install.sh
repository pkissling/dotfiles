#!/usr/bin/env bash
set -e

# create nvim folder, if not exist
mkdir -p "${HOME}"/.config/nvim

# create symlink
ln -sfv "${HOME}"/dotfiles/nvim/init.vim "${HOME}"/.config/nvim

# install plugins
nvim +PluginInstall +qall
