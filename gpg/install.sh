#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

# create .gnupg folder, if not exist
mkdir -p "${HOME}"/.gnupg

# create symlink
ln -sfv "${HOME}"/dotfiles/gpg/gpg-agent.conf "${HOME}"/.gnupg/gpg-agent.conf

# import public gpg keys
gpg --import ~/dotfiles/gpg/private.asc
gpg --import ~/dotfiles/gpg/work.asc

# add private gpg key from 1password, if not exist
if [ -z "$(gpg --list-secret-keys)" ]; then
  if [ "${USAGE}" = "work" ]; then
    ONE_PASSWORD_VAULT="Azena"
  else
    ONE_PASSWORD_VAULT="Personal"
  fi
  ONE_PASSWORD_DOCUMENT_ID=$(op item get 'GPG Private Key' --vault "${ONE_PASSWORD_VAULT}" --format json | jq -r .id)
  gpg --import <(op document get "${ONE_PASSWORD_DOCUMENT_ID}")
fi

# Restart gpg-agent to apply config changes
gpgconf --kill gpg-agent
