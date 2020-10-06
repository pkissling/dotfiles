#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$0")

# create symlink
ln -sfv "${PWD}"/"${BASEDIR}"/.hyper.js "${HOME}"/.hyper.js
