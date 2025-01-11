#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/Library/Application\ Support/com.mitchellh.ghostty

# create symlinks
ln -sfv "${HOME}"/dotfiles/ghostty/config "${HOME}"/Library/Application\ Support/com.mitchellh.ghostty/config
