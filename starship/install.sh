#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$0")

# create .starship and .starship/helper folder, if not exist
mkdir -p "${HOME}"/.starship
mkdir -p "${HOME}"/.starship/helper

# create symlinks for starship.toml config file
ln -sfv "${PWD}"/"${BASEDIR}"/starship.toml "${HOME}"/.starship
# create symlinks for helper scripts
ln -sfv "${PWD}"/"${BASEDIR}"/helper/aws_mfa_renewal_check.sh "${HOME}"/.starship/helper
