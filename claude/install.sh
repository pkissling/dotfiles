#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.claude

# create symlinks
ln -sfv "${HOME}"/dotfiles/claude/settings.json "${HOME}"/.claude/settings.json
ln -sfv "${HOME}"/dotfiles/claude/statusline-command.sh "${HOME}"/.claude/statusline-command.sh
ln -sfv "${HOME}"/dotfiles/claude/.env "${HOME}"/.claude/.env
ln -sfvn "${HOME}"/dotfiles/claude/hooks "${HOME}"/.claude/hooks

# install or update claude code
if command -v claude &>/dev/null; then
  claude update
else
  curl -fsSL https://claude.ai/install.sh | bash
fi
