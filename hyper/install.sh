#!/usr/bin/env bash

BASEDIR=$(dirname $0)

# create symlink
ln -sfv "${PWD}"/"${BASEDIR}"/.hyper.js "${HOME}"