#!/usr/bin/env bash
set -ex

# create mise folder, if not exist
mkdir -p "${XDG_CONFIG_HOME}"/mise

# create config symlink
ln -sfv "${HOME}"/dotfiles/mise/config.toml "${XDG_CONFIG_HOME}"/mise/config.toml

# update plugins
mise plugin update

# install tools
mise install

# update tools
mise up
