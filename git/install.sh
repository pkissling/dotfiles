#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

# create symlinks
ln -sfv "${HOME}"/dotfiles/git/.gitconfig "${HOME}"

# create symlink for profile specific configuration
ln -sfv "${HOME}"/dotfiles/git/.gitconfig_"${USAGE}" "${HOME}"/.gitconfig_user

