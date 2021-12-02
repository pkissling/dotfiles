#!/usr/bin/env bash
set -e

# create nvim folder, if not exist
mkdir -p "${HOME}"/.config/nvim

# create symlink
ln -sfv "${HOME}"/dotfiles/nvim/init.vim "${HOME}"/.config/nvim

# checkout vundle git repo, if not exist
if [ ! -d "${HOME}"/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git "${HOME}"/.vim/bundle/Vundle.vim
fi

# install plugins
nvim +PluginInstall +qall
nvim +PlugUpdate +qall
