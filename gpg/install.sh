#!/usr/bin/env bash
set -ex

# create .gnupg folder, if not exist
mkdir -p "${HOME}"/.gnupg

# create symlink
ln -sfv "${HOME}"/dotfiles/gpg/gpg-agent.conf "${HOME}"/.gnupg
