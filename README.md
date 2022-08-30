# dotfiles

![Lint](https://github.com/pkissling/dotfiles/workflows/Lint/badge.svg) ![Valid links](https://github.com/pkissling/dotfiles/workflows/Valid%20links/badge.svg)

## Overview

This repository contains my personal Dotfiles with configuration
for the following tools:

- [alacritty](https://github.com/alacritty/alacritty)
- [brew](https://brew.sh/)
  - [cask](https://github.com/Homebrew/homebrew-cask)
- [git](https://git-scm.com/)
- [k9s](https://k9scli.io/)
- [gnupg](https://gnupg.org/)
- [nvim](https://neovim.io/)
- [sdkman](https://sdkman.io/)
- [ssh](https://www.ssh.com/)
- [starship](https://starship.rs/)
- [tmux](https://github.com/tmux/tmux)
- [vscode](https://code.visualstudio.com/)
- [zsh](https://ohmyz.sh/)

Each of the folders present contains a dedicated `install.sh` script which
can be used to install the tool and its corresponding configuration manually.

### Screenshots

#### Alacritty with tmux, zsh and Starship

![Alacritty with tmux, zsh and Starship](/.github/screenshots/alacritty_tmux_zsh_starship.png)

#### nvim

![nvim](/.github/screenshots/nvim.png)

### Install

#### All

```bash
make
```

#### Individual targets

##### alacritty

```bash
make alacritty
```

Create symlinks for alacritty config.

##### brew

```bash
make brew
```

Install brew, install & update packages (for brew & cask) via Brewfile.

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

<!-- markdownlint-disable -->
##### nvim
<!-- markdownlint-restore -->
```bash
make nvim
```

Create symlinks for nvim, install & update plugins.

##### rust

```bash
make rust
```

Update rust

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

Install starship shell prompt, create symlinks.

##### tmux

```bash
make tmux
```

Install tpm (tmux plugin manager), create symlinks.

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
