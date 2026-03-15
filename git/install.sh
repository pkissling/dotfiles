#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile 2>/dev/null || true)
BASE_PROFILE="${USAGE}"
[[ "$USAGE" == private-* ]] && BASE_PROFILE="private"

# create new git folder
mkdir -p "${HOME}"/.git

# create symlinks
ln -sfv "${HOME}"/dotfiles/git/.gitconfig "${HOME}"
ln -sfv "${HOME}"/dotfiles/git/.gitignore_global "${HOME}"/.git
ln -sfv "${HOME}"/dotfiles/git/bin "${HOME}"/.git

# create symlink for profile specific configuration, or empty file if USAGE is not set
if [[ -n "${BASE_PROFILE}" && -f "${HOME}/dotfiles/git/.gitconfig_${BASE_PROFILE}" ]]; then
	ln -sfv "${HOME}"/dotfiles/git/.gitconfig_"${BASE_PROFILE}" "${HOME}"/.git/.gitconfig_user
else
	touch "${HOME}"/.git/.gitconfig_user
fi
