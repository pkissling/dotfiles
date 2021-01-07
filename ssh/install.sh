#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

# create .ssh folder, if not exist
mkdir -p "${HOME}"/.ssh

# create symlinks for public certificates
ln -sfv "${HOME}"/dotfiles/ssh/private.pub "${HOME}"/.ssh
ln -sfv "${HOME}"/dotfiles/ssh/work.pub "${HOME}"/.ssh

# create symlink for default public certificate
ln -sfv "${HOME}"/dotfiles/ssh/"${USAGE}".pub "${HOME}"/.ssh/id_rsa.pub

# create symlinks for config file
ln -sfv "${HOME}"/dotfiles/ssh/config "${HOME}"/.ssh
