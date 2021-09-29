#!/usr/bin/env bash
set -e

# install sdkman
# shellcheck source=/dev/null
whick sdk || /bin/bash -c "$(curl -s https://get.sdkman.io)" && source "${HOME}/.sdkman/bin/sdkman-init.sh"

# update sdkman
sdk selfupdate

# install skds
sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' "${HOME}"/dotfiles/sdkman/sdks.txt |
    while read -r SDK
    do
        sdk list "${SDK}" | grep 'installed' || sdk install "${SDK}"
    done

# update sdks
sdk update

# sort sdks.txt file
UUID=$(uuidgen)
sort "${HOME}"/dotfiles/sdkman/sdks.txt > /tmp/"${UUID}"
mv /tmp/"${UUID}" "${HOME}"/dotfiles/sdkman/sdks.txt