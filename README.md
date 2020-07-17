# dotfiles
![Lint](https://github.com/pkissling/dotfiles/workflows/Lint/badge.svg) ![Valid links](https://github.com/pkissling/dotfiles/workflows/Valid%20links/badge.svg)

## Overview
This repository contains my personal Dotfiles with configuration for the following tools:
- [brew](https://brew.sh/)
- [cask](https://github.com/Homebrew/homebrew-cask)
- [git](https://git-scm.com/)
- [gnupg](https://gnupg.org/)
- [iterm](https://iterm2.com/)
- [nvim](https://neovim.io/)
- [sdkman](https://sdkman.io/)
- [ssh](https://www.ssh.com/)
- [vscode](https://code.visualstudio.com/)
- [zsh](https://ohmyz.sh/)

Each of the folders present contains a dedicated `install.sh` script which can be used to install the tool and its corresponding configuration manually.

### Screenshots
#### iTerm2 with zsh
![iTerm2 with zsh](/.screenshots/iterm2_zsh.png)

#### nvim
![nvim](/.screenshots/nvim.png)
### Install
#### All
```bash
make
```
#### Individual targets
##### brew
```bash
make brew
```
Install brew, install & update packages.

##### cask
```bash
make cask
```
Install & update casks.

##### git
```bash
make git
```
Create symlinks for git config.

##### gpg
```bash
make gpg
```
Create symlinks for gpg config.

<!-- markdownlint-disable -->
##### nvim
<!-- markdownlint-restore -->
```bash
make nvim
```
Create symlinks for nvim, install & update plugins.

##### sdkman
```bash
make sdkman
```
Install sdkman, install & update sdks.

##### ssh
```bash
make ssh
```
Create symlinks for ssh config.

##### vscode
```bash
make vscode
```
Create symlinks for vscode configuration, install extensions.

##### zsh
```bash
make zsh
```
Install zsh with Powerlevel10k, create symlinks.
