#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/herdr

# create symlinks
ln -sfv "${HOME}"/dotfiles/herdr/config.toml "${HOME}"/.config/herdr/config.toml

# a running server only picks up config changes on explicit reload
if command -v herdr >/dev/null && herdr status server >/dev/null 2>&1; then
  herdr server reload-config || true
fi
