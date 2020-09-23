#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# create symlinks
ln -sfv "${PWD}"/"${BASEDIR}"/.zshrc "${HOME}"
ln -sfv "${PWD}"/"${BASEDIR}"/.p10k.zsh "${HOME}"

# create symlink to .zshrc_user, if not exists
if [ ! -L "${HOME}"/.zshrc_user ] ; then
  while [[ ! $USAGE =~ (private|work) ]]; do
    read -r -p "Usage (work/private): " USAGE
    export USAGE=$USAGE
  done

  ln -sfv "${PWD}"/"${BASEDIR}"/.zshrc_"${USAGE}" "${HOME}"/.zshrc_user
fi


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

