#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/herdr

# create symlinks
ln -sfv "${HOME}"/dotfiles/herdr/config.toml "${HOME}"/.config/herdr/config.toml
