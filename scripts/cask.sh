#!/usr/bin/env bash

# update
brew cask upgrade

# taps
brew tap homebrew/cask-fonts

# cask
brew cask install 1password
brew cask install boostnote
brew cask install docker
brew cask install font-hack-nerd-font
brew cask install fluor
brew cask install google-chrome
brew cask install hand-mirror
brew cask install hyper
brew cask install nightowl
brew cask install slack
brew cask install spotmenu
brew cask install spotify
brew cask install vlc

# cleanup
brew cleanup
