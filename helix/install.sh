#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/helix

# create symlinks
ln -sfv "${HOME}"/dotfiles/helix/config.toml "${HOME}"/.config/helix/config.toml
