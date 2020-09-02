#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# create symlinks
ln -sfv "${PWD}"/"${BASEDIR}"/.gitconfig "${HOME}"
ln -sfv "${PWD}"/"${BASEDIR}"/.gitignore "${HOME}"

# create symlink to .gitconfig_user, if not exists
if [ ! -L "${HOME}"/.gitconfig_user ] ; then
    read -p 'Usage (work/private): ' USAGE
    ln -sfv "${PWD}"/"${BASEDIR}"/.gitconfig_"${USAGE}" "${HOME}"/.gitconfig_user
fi
