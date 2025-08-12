#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/Library/Application\ Support/com.mitchellh.ghostty
mkdir -p "${HOME}"/Library/Application\ Support/com.mitchellh.ghostty/shaders

# create symlinks
ln -sfv "${HOME}"/dotfiles/ghostty/config "${HOME}"/Library/Application\ Support/com.mitchellh.ghostty/config
ln -sfv "${HOME}"/dotfiles/ghostty/shaders/* "${HOME}"/Library/Application\ Support/com.mitchellh.ghostty/shaders
