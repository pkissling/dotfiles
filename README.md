# My Dotsfiles
A collection of my private Dotfiles contaning configurations for
- [brew](https://brew.sh/)
- [cask](https://github.com/Homebrew/homebrew-cask)
- [git](https://git-scm.com/)
- [hyper](https://hyper.is/)
- [nvim](https://neovim.io/)
- [sdkman](https://sdkman.io/)
- [vscode](https://code.visualstudio.com/)
- [zsh](https://ohmyz.sh/)

## Install
### All
```
$ make
```
### Individual components
```
$ make brew     # install brew, install & update packages
$ make cask     # install & update cask
$ make git      # create symlinks for git config
$ make hyper    # create symlink for hyper configuration
$ make nvim     # create symlinks for nvim, install & update plugins
$ make sdkman   # install sdkman, install & update packages
$ make ssh      # create symlinks for ssh config
$ make vscode   # create symlinks for vscode configuration, install extensions
$ make zsh      # install zsh with Powerlevel10k, create symlinks
