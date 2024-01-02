#!/usr/bin/env bash
set -ex

# create .config/alacritty folder, if not exist
mkdir -p "${HOME}"/.config/alacritty

# create symlinks for alacritty config file
ln -sfv "${HOME}"/dotfiles/alacritty/color.toml "${HOME}"/.config/alacritty
ln -sfv "${HOME}"/dotfiles/alacritty/alacritty.toml "${HOME}"/.config/alacritty
