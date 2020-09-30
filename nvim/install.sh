#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")

# create nvim folder, if not exist
mkdir -p "${HOME}"/.config/nvim

# create symlink
ln -sfv "${PWD}"/"${BASEDIR}"/init.vim "${HOME}"/.config/nvim/

# install plugins
nvim +PluginInstall +qall
