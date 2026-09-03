#!/usr/bin/env bash
set -ex

# create .starship and .starship/helper folder, if not exist
mkdir -p "${HOME}"/.starship
mkdir -p "${HOME}"/.starship/helper

# create symlinks for starship.toml config file
ln -sfv "${HOME}"/dotfiles/starship/starship.toml "${HOME}"/.starship
# create symlinks for helper scripts
ln -sfv "${HOME}"/dotfiles/starship/helper/aws_sso_expired_check.sh "${HOME}"/.starship/helper
