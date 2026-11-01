#!/bin/bash
set -ex

# herdr has no plugin update, so reinstalling at upstream HEAD is how a plugin moves forward
while read -r repo; do
  ref=$(git ls-remote "https://github.com/${repo}.git" HEAD | cut -f1)
  if ! herdr plugin list | grep -q "github:${repo}@${ref}"; then
    herdr plugin install "${repo}" --yes --ref "${ref}"
  fi
done <"${HOME}"/dotfiles/herdr/plugins.list

# a running server only picks up config changes on explicit reload
if command -v herdr >/dev/null && herdr status server >/dev/null 2>&1; then
  herdr server reload-config || true
fi
