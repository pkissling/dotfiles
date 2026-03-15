#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)
BASE_PROFILE="${USAGE}"
[[ "$USAGE" == private-* ]] && BASE_PROFILE="private"

# create symlinks
ln -sfv "${HOME}"/dotfiles/zsh/.zshrc "${HOME}"
ln -sfv "${HOME}"/dotfiles/zsh/.zshrc_"${BASE_PROFILE}" "${HOME}"/.zshrc_profile_specific

# create machine-specific symlink for private profiles
if [[ "$USAGE" == private-* ]]; then
  MACHINE_SUFFIX="${USAGE#private-}"
  ln -sfv "${HOME}"/dotfiles/zsh/.zshrc_private_"${MACHINE_SUFFIX}" "${HOME}"/.zshrc_machine_specific
fi

# install zsh, if not installed already
if [ -z "${ZSH}" ] || ! [ -d "${ZSH}" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

  # set zsh as default shell
  chsh -s /bin/zsh

  # load zsh
  exec /bin/zsh
fi

# upgrade zsh
zsh "$ZSH/tools/upgrade.sh"
