#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# create .ssh folder, if not exist
mkdir -p "${HOME}"/.ssh

# create symlinks
ln -sfv "${PWD}"/"${BASEDIR}"/id_rsa.pub "${HOME}"/.ssh
ln -sfv "${PWD}"/"${BASEDIR}"/config "${HOME}"/.ssh