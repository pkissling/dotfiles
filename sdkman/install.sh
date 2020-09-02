#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

# install sdkman
# shellcheck source=/dev/null
source "${HOME}/.sdkman/bin/sdkman-init.sh" || /bin/bash -c "$(curl -s https://get.sdkman.io)" && source "${HOME}/.sdkman/bin/sdkman-init.sh"

# update sdkman
sdk selfupdate

# install skds
while read -r SDK
do
    sdk list "${SDK}" | grep 'installed' || sdk install "${SDK}"
done < "${BASEDIR}"/sdks.txt

