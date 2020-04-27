#!/usr/bin/env bash

# install sdkman
source "${HOME}/.sdkman/bin/sdkman-init.sh" || /bin/bash -c "$(curl -s https://get.sdkman.io)" 

# update sdkman
sdk selfupdate

# install
sdk list java | grep 'installed' || sdk install java
