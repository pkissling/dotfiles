#!/usr/bin/env bash
set -ex

# create .config/k9s folder, if not exist
mkdir -p "${XDG_CONFIG_HOME}"/k9s

# create skin symlink
ln -sfv "${HOME}"/dotfiles/k9s/dracula.yml "${XDG_CONFIG_HOME}"/k9s/skin.yml
