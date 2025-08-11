#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/claude

# create symlinks
ln -sfv "${HOME}"/dotfiles/claude/settings.json "${HOME}"/.claude/settings.json

# disable auto updates (should be done via brew)
claude config set autoUpdates false

