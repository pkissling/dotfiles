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
brew install ssh-copy-id
brew install watch
brew install yamllint
brew install z

# cask
brew cask install 1password
brew cask install boostnote
brew cask install docker
brew cask install flour
brew cask install hand-mirror
brew cask install iterm2
brew cask install nightowl
brew cask install slack
brew cask install spotify

# cleanup
brew cleanup
