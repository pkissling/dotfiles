#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

# create new git folder
mkdir -p "${HOME}"/.git

# create symlinks
ln -sfv "${HOME}"/dotfiles/git/.gitconfig "${HOME}"
ln -sfv "${HOME}"/dotfiles/git/.gitignore_global "${HOME}"/.git
ln -sfv "${HOME}"/dotfiles/git/bin "${HOME}"/.git

# create symlink for profile specific configuration
ln -sfv "${HOME}"/dotfiles/git/.gitconfig_"${USAGE}" "${HOME}"/.git/.gitconfig_user
