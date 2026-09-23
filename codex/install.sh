#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.codex

# create symlinks
ln -sfv "${HOME}"/dotfiles/claude/CLAUDE.md "${HOME}"/.codex/AGENTS.md
ln -sfv "${HOME}"/dotfiles/codex/hooks.json "${HOME}"/.codex/hooks.json
