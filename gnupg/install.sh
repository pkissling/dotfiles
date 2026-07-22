#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

# create .gnupg folder, if not exist
mkdir -p "${HOME}"/.gnupg

# create symlink
ln -sfv "${HOME}"/dotfiles/gnupg/gpg-agent.conf "${HOME}"/.gnupg/gpg-agent.conf

# import public gnupg keys (only if present; a file may be empty when the key isn't set up)
for key in private work; do
  if [ -s ~/dotfiles/gnupg/"${key}".asc ]; then
    gpg --import ~/dotfiles/gnupg/"${key}".asc
  fi
done

# add private gnupg key from 1password, if not exist
if [ -z "$(gpg --list-secret-keys)" ]; then
  if [ "${USAGE}" = "work" ]; then
    ONE_PASSWORD_VAULT="Azena"
  else
    ONE_PASSWORD_VAULT="Personal"
  fi
  ONE_PASSWORD_DOCUMENT_ID=$(op item get 'GPG Private Key' --vault "${ONE_PASSWORD_VAULT}" --format json | jq -r .id)
  gpg --import <(op document get "${ONE_PASSWORD_DOCUMENT_ID}")
fi

# Restart gnupg-agent to apply config changes
gpgconf --kill gpg-agent
