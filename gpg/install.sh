#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# create .gnupg folder, if not exist
mkdir -p "${HOME}"/.gnupg

# create symlink
ln -sfv "${PWD}"/"${BASEDIR}"/gpg-agent.conf "${HOME}"/.gnupg