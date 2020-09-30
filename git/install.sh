#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$0")

# create symlinks
ln -sfv "${PWD}"/"${BASEDIR}"/.gitconfig "${HOME}"
ln -sfv "${PWD}"/"${BASEDIR}"/.gitignore "${HOME}"

# create symlink to .gitconfig_user, if not exists
if [ ! -L "${HOME}"/.gitconfig_user ] ; then
  while [[ ! $USAGE =~ (private|work) ]]; do
    read -r -p "Usage (work/private): " USAGE
    export USAGE=$USAGE
  done

  ln -sfv "${PWD}"/"${BASEDIR}"/.gitconfig_"${USAGE}" "${HOME}"/.gitconfig_user
fi
