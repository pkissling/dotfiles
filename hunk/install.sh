#!/bin/bash
set -ex

# symlink bundled hunk-review skill into Claude Code (mise "latest" keeps it in sync across upgrades)
SKILL_DIRS=("${HOME}"/.local/share/mise/installs/hunk/latest/*/skills/hunk-review)
ln -sfvn "${SKILL_DIRS[0]}" "${HOME}"/.claude/skills/hunk-review
