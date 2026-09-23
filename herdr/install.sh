#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/herdr

# create symlinks
ln -sfv "${HOME}"/dotfiles/herdr/config.toml "${HOME}"/.config/herdr/config.toml

# herdr has no plugin update, so reinstalling at upstream HEAD is how a plugin moves forward
changed=false
while read -r repo; do
  ref=$(git ls-remote "https://github.com/${repo}.git" HEAD | cut -f1)
  if ! herdr plugin list | grep -q "github:${repo}@${ref}"; then
    herdr plugin install --yes --ref "${ref}" "${repo}"
    changed=true
  fi
done <"${HOME}"/dotfiles/herdr/plugins.list

# a running server only picks up config changes on explicit reload
if command -v herdr >/dev/null && herdr status server >/dev/null 2>&1; then
  herdr server reload-config || true
  if [ "${changed}" = true ]; then
    herdr plugin action invoke herdr.auto-title.restart || true
  fi
fi
