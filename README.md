# dotfiles
[![Build Status](https://travis-ci.org/pkissling/dotfiles.svg?branch=master)](https://travis-ci.org/pkissling/dotfiles)

# Overview
Each of the folders present contains a dedicated `install.sh` script which can be used to install the tool and its corresponding configuration manually.

## Screenshots
### iTerm2 with zsh
![iTerm2 with zsh](/.screenshots/iterm2_zsh.png)

### nvim
![nvim](/.screenshots/nvim.png)
## Install
### All
```
$ make
```
### Individual targets
#### brew
```
$ make brew
```
Install brew, install & update packages.

#### cask
```
$ make cask
```
Install & update casks.

#### git
```
$ make git
```
Create symlinks for git config.

#### gpg
```
$ make gpg
```
Create symlinks for gpg config.

#### nvim
```
$ make nvim
```
Create symlinks for nvim, install & update plugins.

#### sdkman
```
$ make sdkman
```
Install sdkman, install & update sdks.

#### ssh
```
$ make ssh
```
Create symlinks for ssh config.

#### vscode
```
$ make vscode
```
Create symlinks for vscode configuration, install extensions.

#### zsh
```
$ make zsh
```
Cnstall zsh with Powerlevel10k, create symlinks.