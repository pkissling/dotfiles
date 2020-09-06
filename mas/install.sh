#!/usr/bin/env bash
BASEDIR=$(dirname "$0")

# install apps
sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' "${BASEDIR}/apps.txt" |
    while read -r APP
    do
        mas install "$APP"
    done