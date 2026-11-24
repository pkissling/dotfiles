#!/usr/bin/env bash
set -ex

mkdir -p "${HOME}"/.starship

# create symlinks for starship.toml config file
ln -sfv "${HOME}"/dotfiles/starship/starship.toml "${HOME}"/.starship
