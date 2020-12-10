# dotfiles
![Lint](https://github.com/pkissling/dotfiles/workflows/Lint/badge.svg) ![Valid links](https://github.com/pkissling/dotfiles/workflows/Valid%20links/badge.svg)

## Overview
This repository contains my personal Dotfiles with configuration
for the following tools:
- [brew](https://brew.sh/)
- [cask](https://github.com/Homebrew/homebrew-cask)
- [git](https://git-scm.com/)
- [gnupg](https://gnupg.org/)
- [hyper.js](https://hyper.is/)
- [nvim](https://neovim.io/)
- [mas](https://github.com/mas-cli/mas)
- [sdkman](https://sdkman.io/)
- [ssh](https://www.ssh.com/)
- [starship](https://starship.rs/)
- [vscode](https://code.visualstudio.com/)
- [zsh](https://ohmyz.sh/)

Each of the folders present contains a dedicated `install.sh` script which
can be used to install the tool and its corresponding configuration manually.

### Screenshots
#### Hyper.js with zsh and Starship
![Hyper.js with zsh and Starship](/.github/screenshots/hyper_zsh_starship.png)

#### nvim
![nvim](/.github/screenshots/nvim.png)
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

##### hyper
```bash
make hyper
```
Create symlinks for gpg config.

<!-- markdownlint-disable -->
##### nvim
<!-- markdownlint-restore -->
```bash
make nvim
```
Create symlinks for nvim, install & update plugins.

##### mas
```bash
make mas
```
Install Mac App Store apps.

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

##### starship
```bash
make starship
```
Install starship shell prompot , create symlinks.

##### vscode
```bash
make vscode
```
Create symlinks for vscode configuration, install extensions.

##### zsh
```bash
make zsh
```
Install zsh, create symlinks.
