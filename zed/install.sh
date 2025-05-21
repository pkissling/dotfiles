#!/bin/bash
set -ex

# create config dir, if not exists
mkdir -p "${HOME}/.config/zed"

# create symlinks
ln -sfv "${HOME}"/dotfiles/zed/settings.json "${HOME}"/.config/zed/settings.json
