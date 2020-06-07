#!/usr/bin/env bash

BASEDIR=$(dirname $0)

# install extensions
while read EXTENSION
do
    code --install-extension $EXTENSION
done < "${BASEDIR}"/extensions.txt

# cleanup
brew cleanup
