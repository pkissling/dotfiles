#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$0")

# install sdkman
# shellcheck source=/dev/null
source "${HOME}/.sdkman/bin/sdkman-init.sh" || /bin/bash -c "$(curl -s https://get.sdkman.io)" && source "${HOME}/.sdkman/bin/sdkman-init.sh"

# update sdkman
sdk selfupdate

# install skds
sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' "${BASEDIR}/sdks.txt" |
    while read -r SDK
    do
        sdk list "${SDK}" | grep 'installed' || sdk install "${SDK}"
    done

# update sdks
sdk update

# sort sdks.txt file
UUID=$(uuidgen)
sort "${BASEDIR}"/sdks.txt > /tmp/"${UUID}"
mv /tmp/"${UUID}" "${BASEDIR}"/sdks.txt