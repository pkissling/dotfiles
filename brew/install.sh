#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$0")

# install brew, if not installed
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# update brew
brew update
brew upgrade

# compare list of installed packages with packages.txt and identify delta
MISSING_PACKAGES=$(brew list | grep --ignore-case --invert-match --file /dev/stdin brew/packages.txt) || true
for MISSING_PACKAGE in ${MISSING_PACKAGES}; do
    brew install "${MISSING_PACKAGE}"
done

# cleanup
brew cleanup

# sort packages.txt file
UUID=$(uuidgen)
sort "${BASEDIR}"/packages.txt > /tmp/"${UUID}"
mv /tmp/"${UUID}" "${BASEDIR}"/packages.txt
