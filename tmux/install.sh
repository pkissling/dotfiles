#!/usr/bin/env bash
set -ex

# create .tmux folder, if not exist
mkdir -p "${HOME}"/.tmux/plugins

# checkout tpm git repo, if not exist
if [ ! -d "${HOME}"/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm "${HOME}"/.tmux/plugins/tpm
  tmux source ~/.tmux.conf
fi

# create symlink
ln -sfv "${HOME}"/dotfiles/tmux/.tmux.conf "${HOME}"
