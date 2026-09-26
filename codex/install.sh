#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.codex

# create symlinks
ln -sfv "${HOME}"/dotfiles/agents/AGENTS.md "${HOME}"/.codex/AGENTS.md
ln -sfv "${HOME}"/dotfiles/codex/config.toml "${HOME}"/.codex/config.toml
ln -sfv "${HOME}"/dotfiles/codex/hooks.json "${HOME}"/.codex/hooks.json
mkdir -p "${HOME}"/.agents/skills
ln -sfvn "${HOME}"/dotfiles/agents/skills/review-notes "${HOME}"/.agents/skills/review-notes
