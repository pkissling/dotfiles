#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/herdr "${HOME}"/.config/herdr-auto-title

# create symlinks
ln -sfv "${HOME}"/dotfiles/herdr/config.toml "${HOME}"/.config/herdr/config.toml
ln -sfv "${HOME}"/dotfiles/herdr/auto-title.env "${HOME}"/.config/herdr-auto-title/config.env

# herdr has no plugin update, so reinstalling at upstream HEAD is how a plugin moves forward
while read -r repo; do
  ref=$(git ls-remote "https://github.com/${repo}.git" HEAD | cut -f1)
  if ! herdr plugin list | grep -q "github:${repo}@${ref}"; then
    herdr plugin install --yes --ref "${ref}" "${repo}"
  fi
done <"${HOME}"/dotfiles/herdr/plugins.list

# a running server only picks up config changes on explicit reload, and auto-title reads its config only at startup
if command -v herdr >/dev/null && herdr status server >/dev/null 2>&1; then
  herdr server reload-config || true
  herdr plugin action invoke herdr.auto-title.restart || true
fi
