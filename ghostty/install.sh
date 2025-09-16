#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/ghostty

# create symlinks
ln -sfv "${HOME}"/dotfiles/ghostty/config "${HOME}"/.config/ghostty/config
rm -f "${HOME}"/.config/ghostty/shaders
ln -sfv "${HOME}"/dotfiles/ghostty/shaders "${HOME}"/.config/ghostty/shaders
