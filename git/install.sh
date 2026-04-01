#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile 2>/dev/null || true)

# create symlinks
ln -sfv "${HOME}"/dotfiles/git/.gitconfig "${HOME}"
ln -sfv "${HOME}"/dotfiles/git/.gitignore_global "${HOME}"
ln -sfv "${HOME}"/dotfiles/git/.git_functions "${HOME}"/.git_functions

# create symlink for profile specific configuration, or empty file if USAGE is not set
if [[ -n "${USAGE}" && -f "${HOME}/dotfiles/git/.gitconfig_${USAGE}" ]]; then
	ln -sfv "${HOME}"/dotfiles/git/.gitconfig_"${USAGE}" "${HOME}"/.gitconfig_user
else
	touch "${HOME}"/.gitconfig_user
fi
