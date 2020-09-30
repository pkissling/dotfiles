#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$0")

# create .ssh folder, if not exist
mkdir -p "${HOME}"/.ssh

# create symlinks for public certificates
ln -sfv "${PWD}"/"${BASEDIR}"/private.pub "${HOME}"/.ssh
ln -sfv "${PWD}"/"${BASEDIR}"/work.pub "${HOME}"/.ssh

# create symlinks for config file
ln -sfv "${PWD}"/"${BASEDIR}"/config "${HOME}"/.ssh

# create symlink to default id_rsa file, if not exists
if [ ! -L "${HOME}"/.ssh/id_rsa.pub ] ; then
  while [[ ! $USAGE =~ (private|work) ]]; do
    read -r -p "Usage (work/private): " USAGE
    export USAGE=$USAGE
  done

  ln -sfv "${PWD}"/"${BASEDIR}"/"${USAGE}".pub "${HOME}"/.ssh/id_rsa.pub
fi
