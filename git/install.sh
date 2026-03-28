#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile 2>/dev/null || true)

# create new git folder
mkdir -p "${HOME}"/.git

# create symlinks
ln -sfv "${HOME}"/dotfiles/git/.gitconfig "${HOME}"
ln -sfv "${HOME}"/dotfiles/git/.gitignore_global "${HOME}"/.git
ln -sfv "${HOME}"/dotfiles/git/bin "${HOME}"/.git

# create symlink for profile specific configuration, or empty file if USAGE is not set
if [[ -n "${USAGE}" && -f "${HOME}/dotfiles/git/.gitconfig_${USAGE}" ]]; then
	ln -sfv "${HOME}"/dotfiles/git/.gitconfig_"${USAGE}" "${HOME}"/.git/.gitconfig_user
else
	touch "${HOME}"/.git/.gitconfig_user
fi
