#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

# add private ssh key from 1password, if not exist
# shellcheck disable=SC2140
if [ ! -f "${HOME}"/.ssh/"${USAGE}.priv" ]; then
  if [ "${USAGE}" = "work" ]; then
    ONE_PASSWORD_VAULT="EBX"
  else
    ONE_PASSWORD_VAULT="Personal"
  fi
  ONE_PASSWORD_DOCUMENT_ID=$(op item get 'SSH Private Key' --vault "${ONE_PASSWORD_VAULT}" --format json | jq -r .id)
  # shellcheck disable=SC2140
  op read op://"${ONE_PASSWORD_VAULT}"/"${ONE_PASSWORD_DOCUMENT_ID}"/'private key'?ssh-format=openssh > "${HOME}"/.ssh/"${USAGE}.priv"
  chmod 600 "${HOME}"/.ssh/"${USAGE}.priv"
fi
