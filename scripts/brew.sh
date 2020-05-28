#!/usr/bin/env bash

# install brew
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# update brew
brew update
brew upgrade

# brew
brew install autoenv
brew install ag
brew install awscli
brew install bat
brew install direnv
brew install kubectl
brew install gradle
brew install git
brew install git-delta
brew install htop
brew install httpie
brew install jupyter
brew install jq
brew install neovim
brew install romkatv/powerlevel10k/powerlevel10k
brew install rustup
brew install ssh-copy-id
brew install terraform
brew install tree
brew install watch
brew install wget
brew install yamllint
brew install z
brew install zsh
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# cleanup
brew cleanup
