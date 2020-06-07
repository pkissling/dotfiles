#!/usr/bin/env bash

BASEDIR=$(dirname $0)

# create symlink
ln -sfv "${PWD}"/"${BASEDIR}"/init.vim "${HOME}"/.config/nvim/

# install plugins
nvim +PluginInstall +qall
