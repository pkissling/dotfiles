#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# create symlinks
ln -sfv "${PWD}"/"${BASEDIR}"/.gitconfig "${HOME}"
ln -sfv "${PWD}"/"${BASEDIR}"/.gitignore "${HOME}"