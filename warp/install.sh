#!/bin/bash
set -ex

UUID=$(uuidgen)

# save previous config
defaults read dev.warp.Warp-Stable > "/tmp/${UUID}"
sed -i '' "s|/Users/$(whoami)|$\{HOME\}|g" "/tmp/${UUID}"

# write net config to warp
defaults write dev.warp.Warp-Stable -string "${HOME}"/dotfiles/warp/settings.plist

# dont log following generation of warp settings delta
set +x

DELTA=$(grep --fixed-strings --line-regexp --file /tmp/"${UUID}" "${HOME}"/dotfiles/warp/settings.plist | grep --invert-match --file "${HOME}"/dotfiles/warp/ignored_config_keys.txt)
if [ -n "${DELTA}" ]; then
  echo "${DELTA}" > "${HOME}"/dotfiles/warp/settings.plist
fi
