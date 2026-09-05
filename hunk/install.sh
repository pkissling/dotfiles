#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/hunk

# create symlinks
ln -sfv "${HOME}"/dotfiles/hunk/config.toml "${HOME}"/.config/hunk/config.toml

# symlink bundled hunk-review skill into Claude Code (mise "latest" keeps it in sync across upgrades)
mkdir -p "${HOME}"/.claude/skills
SKILL_DIRS=("${HOME}"/.local/share/mise/installs/hunk/latest/*/skills/hunk-review)
ln -sfvn "${SKILL_DIRS[0]}" "${HOME}"/.claude/skills/hunk-review
