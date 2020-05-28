# My Dotsfiles
A collection of my private Dotfiles contaning configurations for
- git
- ssh
- vim
- Visual Studio Code
- zsh

## Install
### All
```
$ make
```
### Individual components
```
$ make symlinks     # create symlinks for dotfiles
$ make brew         # install and update brew packages
$ make cask         # install and update brew cask packages
$ make sdkman       # install sdkman, install and udpate sdks
$ make vim          # install and configure neovim
$ make zsh          # install and configure zsh with Powerlevel10k