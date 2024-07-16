#!/bin/bash
set -ex

# save previous config
UUID=$(uuidgen)
defaults read dev.warp.Warp-Stable > "/tmp/${UUID}"
sed -i '' "s|/Users/$(whoami)|$\{HOME\}|g" "/tmp/${UUID}"

# write net config to warp
defaults write dev.warp.Warp-Stable -string "${HOME}"/dotfiles/warp/settings.plist
DELTA=$(grep -vFxf "/tmp/${UUID}" "${HOME}"/dotfiles/warp/settings.plist || true)
if [ -n "${DELTA}" ]; then
  echo "${DELTA}" >> "${HOME}"/dotfiles/warp/settings.plist
fi
