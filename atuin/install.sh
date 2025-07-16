#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/atuin

# create symlinks
ln -sfv "${HOME}"/dotfiles/atuin/config.toml "${HOME}"/.config/atuin/config.toml

