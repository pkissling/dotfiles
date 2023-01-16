#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

# create .gnupg folder, if not exist
mkdir -p "${HOME}"/.gnupg

# create symlink
ln -sfv "${HOME}"/dotfiles/gpg/gpg-agent_"${USAGE}".conf "${HOME}"/.gnupg/gpg-agent.conf

# import public gpg keys
gpg --import ~/dotfiles/gpg/private.asc
gpg --import ~/dotfiles/gpg/work.asc
