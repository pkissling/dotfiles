#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.claude

# create symlinks
ln -sfv "${HOME}"/dotfiles/agents/AGENTS.md "${HOME}"/.claude/CLAUDE.md
ln -sfv "${HOME}"/dotfiles/claude/settings.json "${HOME}"/.claude/settings.json
ln -sfv "${HOME}"/dotfiles/claude/statusline-command.sh "${HOME}"/.claude/statusline-command.sh
ln -sfvn "${HOME}"/dotfiles/claude/hooks "${HOME}"/.claude/hooks
mkdir -p "${HOME}"/.claude/skills
ln -sfvn "${HOME}"/dotfiles/agents/skills/review-notes "${HOME}"/.claude/skills/review-notes

# install or update claude code
if command -v claude &>/dev/null; then
  claude update
else
  curl -fsSL https://claude.ai/install.sh | bash
fi
