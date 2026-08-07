#!/usr/bin/env bash
set -e

# create config folder, if not exist
mkdir -p "${HOME}"/.config

# remove existing nvim directory/symlink
rm -rf "${HOME}/.config/nvim"

# create symlink
ln -sfv "${HOME}"/dotfiles/nvim "${HOME}"/.config/nvim

# discard local changes in plugin repos so lazy can update them
for plugin in "${HOME}"/.local/share/nvim/lazy/*/; do
    if [ -d "${plugin}/.git" ]; then
        git -C "${plugin}" reset --hard --quiet
    fi
done

# update plugins
nvim --headless "+Lazy! sync" +qa
