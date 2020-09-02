#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# create .ssh folder, if not exist
mkdir -p "${HOME}"/.ssh

# create symlinks
ln -sfv "${PWD}"/"${BASEDIR}"/private.pub "${HOME}"/.ssh
ln -sfv "${PWD}"/"${BASEDIR}"/work.pub "${HOME}"/.ssh
ln -sfv "${PWD}"/"${BASEDIR}"/config "${HOME}"/.ssh

# create symlink to default id_rsa file, if not exists
if [ ! -L "${HOME}"/.ssh/id_rsa.pub ] ; then
    read -p 'Usage (work/private): ' USAGE
    ln -sfv "${PWD}"/"${BASEDIR}"/"${USAGE}".pub "${HOME}"/.ssh/id_rsa.pub
fi
