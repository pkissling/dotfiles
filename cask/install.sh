#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$0")

# update
brew upgrade --cask

# compare list of installed packages with packages.txt and identify delta
MISSING_PACKAGES=$(brew list --cask | grep --ignore-case --invert-match --file /dev/stdin cask/packages.txt) || true
for MISSING_PACKAGE in ${MISSING_PACKAGES}; do
    brew install --cask "${MISSING_PACKAGE}"
done

# cleanup
brew cleanup

# sort packages.txt file
UUID=$(uuidgen)
sort "${BASEDIR}"/packages.txt > /tmp/"${UUID}"
mv /tmp/"${UUID}" "${BASEDIR}"/packages.txt
