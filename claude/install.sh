#!/bin/bash
set -ex

# sort settings.json
TMP=$(mktemp)
jq --sort-keys < "${HOME}"/dotfiles/claude/settings.json > "${TMP}"
mv "${TMP}" "${HOME}"/dotfiles/claude/settings.json

# install or update claude code
if command -v claude &>/dev/null; then
  claude update
else
  curl -fsSL https://claude.ai/install.sh | bash
fi
