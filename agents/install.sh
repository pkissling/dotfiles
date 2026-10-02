#!/bin/bash
set -ex

# create symlinks
mkdir -p "${HOME}"/.agents/skills
ln -sfv "${HOME}"/dotfiles/agents/AGENTS.local.md "${HOME}"/.agents/AGENTS.local.md
ln -sfvn "${HOME}"/dotfiles/agents/skills/review-notes "${HOME}"/.agents/skills/review-notes
