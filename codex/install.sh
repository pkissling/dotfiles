#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.codex

# create symlinks
ln -sfv "${HOME}"/dotfiles/codex/config.toml "${HOME}"/.codex/config.toml

