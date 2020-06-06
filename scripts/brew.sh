#!/usr/bin/env bash

packages=(
    autoenv
    ag
    awscli
    bat
    direnv
    exa
    kubectl
    gradle
    git
    git-delta
    htop
    httpie
    jupyter
    jq
    neovim
    romkatv/powerlevel10k/powerlevel10k
    rustup
    ssh-copy-id
    terraform
    tree
    watch
    wget
    yamllint
    z
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# install brew
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# update brew
brew update
brew upgrade

# install packages
for package in ${packages[@]}
do
    brew list "$package" || brew install "$package"
done

# cleanup
brew cleanup
