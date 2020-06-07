#!/usr/bin/env bash

BASEDIR=$(dirname $0)

# create symlinks
ln -sfv "${PWD}"/"${BASEDIR}"/.zshrc "${HOME}"
ln -sfv "${PWD}"/"${BASEDIR}"/.p10k.zsh "${HOME}"

# install zsh, if not installed already
if [ -z "${ZSH}" ] || ! [ -d "${ZSH}" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

  # set zsh as default shell
  chsh -s /bin/zsh

  # load zsh
  zsh
fi

# upgrade zsh
sh "$ZSH/tools/upgrade.sh"

