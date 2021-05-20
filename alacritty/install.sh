#!/usr/bin/env bash
set -ex

# create .config/alacritty folder, if not exist
mkdir -p "${HOME}"/.config/alacritty

# create symlinks for alacritty config file
ln -sfv "${HOME}"/dotfiles/alacritty/color.yml "${HOME}"/.config/alacritty
ln -sfv "${HOME}"/dotfiles/alacritty/alacritty.yml "${HOME}"/.config/alacritty
