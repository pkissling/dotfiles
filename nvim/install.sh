#!/usr/bin/env bash
set -e

# discard local changes in plugin repos so lazy can update them
for plugin in "${HOME}"/.local/share/nvim/lazy/*/; do
    if [ -d "${plugin}/.git" ]; then
        git -C "${plugin}" reset --hard --quiet
    fi
done

# update plugins
nvim --headless "+Lazy! sync" +qa
