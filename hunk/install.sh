#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/hunk

# create symlinks
ln -sfv "${HOME}"/dotfiles/hunk/config.toml "${HOME}"/.config/hunk/config.toml

# symlink bundled hunk-review skill into Claude Code (mise "latest" keeps it in sync across upgrades)
mkdir -p "${HOME}"/.claude/skills
ln -sfvn "${HOME}"/.local/share/mise/installs/hunk/latest/*/skills/hunk-review "${HOME}"/.claude/skills/hunk-review
