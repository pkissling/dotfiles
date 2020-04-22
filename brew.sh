#!/usr/bin/env bash

# install brew
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# update brew
brew update
brew upgrade

# brew
brew install bat
brew install kubectl
brew install git
brew install htop
brew install httpie
brew install jq
brew install romkatv/powerlevel10k/powerlevel10k
brew install rustup
brew install ssh-copy-id
brew install watch
brew install yamllint
brew install z
brew install zsh
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# cleanup
brew cleanup
