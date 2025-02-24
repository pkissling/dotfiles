#!/bin/bash
set -ex

# create symlinks
ln -sfv "${HOME}"/dotfiles/zed/settings.json "${HOME}"/.config/zed/settings.json
