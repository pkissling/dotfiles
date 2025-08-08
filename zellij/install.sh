#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/zellij

# create symlinks
ln -sfv "${HOME}"/dotfiles/zellij/config.kdl "${HOME}"/.config/zellij/config.kdl
ln -sfv "${HOME}"/dotfiles/zellij/layouts "${HOME}"/.config/zellij/layouts
