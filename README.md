# dotfiles
[![Build Status](https://travis-ci.org/pkissling/dotfiles.svg?branch=master)](https://travis-ci.org/pkissling/dotfiles)

## Overview
This repository contains my personal Dotfiles with configuration for the following tools:
- [brew](https://brew.sh/)
- [cask](https://github.com/Homebrew/homebrew-cask)
- [git](https://git-scm.com/)
- [gnupg](https://gnupg.org/)
- [hyper](https://hyper.is/)
- [nvim](https://neovim.io/)
- [sdkman](https://sdkman.io/)
- [ssh](https://www.ssh.com/)
- [vscode](https://code.visualstudio.com/)
- [zsh](https://ohmyz.sh/)

Each of the folders present contains a dedicated `install.sh` script which can be used to install the tool and its corresponding configration manually.

## Screenshots
### hyper with zsh
![Hyper with zsh](/.screenshots/hyper_zsh.png)

### nvim
![Hyper with zsh](/.screenshots/nvim.png)
## Install
### All tools
```
$ make
```
### Individual targets
```
$ make brew     # install brew, install & update packages
$ make cask     # install & update cask
$ make git      # create symlinks for git config
$ make gpg      # create symlinks for gpg config
$ make hyper    # create symlink for hyper configuration
$ make nvim     # create symlinks for nvim, install & update plugins
$ make sdkman   # install sdkman, install & update packages
$ make ssh      # create symlinks for ssh config
$ make vscode   # create symlinks for vscode configuration, install extensions
$ make zsh      # install zsh with Powerlevel10k, create symlinks
