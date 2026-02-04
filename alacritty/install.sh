#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/alacritty

# create symlinks
ln -sfv "${HOME}"/dotfiles/alacritty/alacritty.toml "${HOME}"/.config/alacritty/alacritty.toml
