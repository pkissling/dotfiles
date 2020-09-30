#!/usr/bin/env bash
BASEDIR=$(dirname "$0")

# install apps
sed -e 's/[[:space:]]*#.*// ; /^[[:space:]]*$/d' "${BASEDIR}/apps.txt" |
    while read -r APP
    do
        mas lucky "$APP"
    done

# update existing apps
mas upgrade

# sort apps.txt file
UUID=$(uuidgen)
sort "${BASEDIR}"/apps.txt > /tmp/"${UUID}"
mv /tmp/"${UUID}" "${BASEDIR}"/apps.txt