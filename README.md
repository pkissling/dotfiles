# dotfiles

![Lint](https://github.com/pkissling/dotfiles/workflows/Lint/badge.svg) ![Valid links](https://github.com/pkissling/dotfiles/workflows/Valid%20links/badge.svg)

## Overview

This repository contains my personal Dotfiles with configuration
for the following tools:

- [brew](https://brew.sh/)
  - [cask](https://github.com/Homebrew/homebrew-cask)
- [git](https://git-scm.com/)
- [k9s](https://k9scli.io/)
- [gnupg](https://gnupg.org/)
- [mise](https://mise.jdx.dev/)
- [nvim](https://neovim.io/)
- [ssh](https://www.ssh.com/)
- [starship](https://starship.rs/)
- [vscode](https://code.visualstudio.com/)
- [zed](https://zed.dev/)
- [zsh](https://ohmyz.sh/)

Each of the folders present contains a dedicated `install.sh` script which
can be used to install the tool and its corresponding configuration manually.

### Screenshots

#### Warp with zsh and Starship

![Warp with zsh and Starship](/.github/screenshots/warp_zsh_starship.png)

#### nvim

![nvim](/.github/screenshots/nvim.png)

### Install

#### All

```bash
make
```

##### brew

```bash
make brew
```

Install brew, install & update packages (for brew & cask) via Brewfile.

##### ghostty

```bash
make ghostty
```

Create symlinks for ghostty config.

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

##### k9s

```bash
make k9s
```

Create symlinks for k9s config.

##### mise

```bash
make mise
```

Install mise, install & update tools using mise.

<!-- markdownlint-disable -->
##### nvim
<!-- markdownlint-restore -->
```bash
make nvim
```

Create symlinks for nvim, install & update plugins.

##### pam

```bash
make pam
```

Configure macOS to allow `sudo` to use Touch ID.

##### ssh

```bash
make ssh
```

Create symlinks for ssh config.

##### starship

```bash
make starship
```

Install starship shell prompt, create symlinks.

##### vscode

```bash
make vscode
```

Create symlinks for vscode configuration, install extensions.
  
##### zed

```bash
make zed
```

Install zed text editor, create symlinks.

##### zsh

```bash
make zsh
```

Install zsh, create symlinks.
