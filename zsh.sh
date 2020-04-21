#!/usr/bin/env bash

# install zsh, if not installed already
# 1. check if ZSH environment variable is set
# 2. check if ZSH folder actually exists
if [ -z "${ZSH}" ] || ! [ -d "${ZSH}" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

  # load zsh
  zsh

  # set zsh as default shell
  chsh -s /bin/zsh
fi



# update zsh
cd $ZSH && git pull origin master
