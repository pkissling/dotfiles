#!/bin/bash
set -ex

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# unlock git-crypt
git -C "${DOTFILES_DIR}" stash
git -C "${DOTFILES_DIR}" crypt unlock
git -C "${DOTFILES_DIR}" stash pop || true

# ensure config directory exists
mkdir -p "${HOME}"/.claude

# create symlinks
ln -sfv "${HOME}"/dotfiles/claude/settings.json "${HOME}"/.claude/settings.json
ln -sfv "${HOME}"/dotfiles/claude/statusline-command.sh "${HOME}"/.claude/statusline-command.sh
ln -sfv "${HOME}"/dotfiles/claude/.env "${HOME}"/.claude/.env
ln -sfvn "${HOME}"/dotfiles/claude/hooks "${HOME}"/.claude/hooks

