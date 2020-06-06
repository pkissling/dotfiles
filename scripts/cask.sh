#!/usr/bin/env bash

packages=(
    1password
    boostnote
    docker
    font-hack-nerd-font
    fluor
    google-chrome
    hand-mirror
    hyper
    nightowl
    slack
    spotmenu
    spotify
    vlc
)

# update
brew cask upgrade

# taps
brew tap homebrew/cask-fonts

# install packages
for package in ${packages[@]}
do
    brew cask list "$package" || brew cask install "$package"
done

# cleanup
brew cleanup
