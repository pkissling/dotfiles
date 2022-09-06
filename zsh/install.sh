#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

# create symlinks
ln -sfv "${HOME}"/dotfiles/zsh/.zshrc "${HOME}"
ln -sfv "${HOME}"/dotfiles/zsh/.zshrc_"${USAGE}" "${HOME}"/.zshrc_user

# install zsh, if not installed already
if [ -z "${ZSH}" ] || ! [ -d "${ZSH}" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

  # set zsh as default shell
  chsh -s /bin/zsh

  # load zsh
  exec /bin/zsh
fi

# upgrade zsh
sh "$ZSH/tools/upgrade.sh"
