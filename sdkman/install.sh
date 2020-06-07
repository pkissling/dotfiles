#!/usr/bin/env bash

BASEDIR=$(dirname $0)

# install sdkman
source "${HOME}/.sdkman/bin/sdkman-init.sh" || /bin/bash -c "$(curl -s https://get.sdkman.io)"

# update sdkman
sdk selfupdate

# install skds
while read SDK
do
    sdk list "${SDK}" | grep 'installed' || sdk install "${SDK}"
done < "${BASEDIR}"/sdks.txt

