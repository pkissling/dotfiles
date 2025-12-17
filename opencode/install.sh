#!/usr/bin/env bash
set -e

# create config folder, if not exist
mkdir -p "${HOME}"/.config/opencode

# create symlink
ln -sfv "${HOME}"/dotfiles/opencode/opencode.jsonc "${HOME}"/.config/opencode/opencode.jsonc

