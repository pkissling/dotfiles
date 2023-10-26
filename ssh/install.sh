#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

# create .ssh folder, if not exist
mkdir -p "${HOME}"/.ssh

# create symlinks for public certificates
ln -sfv "${HOME}"/dotfiles/ssh/private.pub "${HOME}"/.ssh
ln -sfv "${HOME}"/dotfiles/ssh/work.pub "${HOME}"/.ssh

# create symlink for default private and public certificate
ln -sfv "${HOME}"/dotfiles/ssh/"${USAGE}".pub "${HOME}"/.ssh/id_rsa.pub
ln -sfv "${HOME}"/.ssh/"${USAGE}".priv "${HOME}"/.ssh/id_rsa

# create symlinks for config file
ln -sfv "${HOME}"/dotfiles/ssh/config "${HOME}"/.ssh

# add private ssh key from 1password, if not exist
# shellcheck disable=SC2140
if [ ! -f "${HOME}"/.ssh/"${USAGE}.priv" ]; then
  if [ "${USAGE}" = "work" ]; then
    ONE_PASSWORD_VAULT="Azena"
  else
    ONE_PASSWORD_VAULT="Personal"
  fi
  ONE_PASSWORD_DOCUMENT_ID=$(op item get 'SSH Private Key' --vault "${ONE_PASSWORD_VAULT}" --format json | jq -r .id)
  # shellcheck disable=SC2140
  op read op://"${ONE_PASSWORD_VAULT}"/"${ONE_PASSWORD_DOCUMENT_ID}"/'private key' > "${HOME}"/.ssh/"${USAGE}.priv"
  chmod 600 "${HOME}"/.ssh/"${USAGE}.priv"
fi
