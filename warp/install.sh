#!/bin/bash
set -ex

defaults write dev.warp.Warp-Stable -string "${HOME}"/dotfiles/warp/settings.plist
defaults read dev.warp.Warp-Stable > "${HOME}"/dotfiles/warp/settings.plist
