#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$0")

# compare list of installed apps with apps.txt and identify delta
MISSING_APPS=$(mas list | awk '{ print $2 }'| grep --ignore-case --invert-match --file /dev/stdin mas/apps.txt) || true
for MISSING_APP in ${MISSING_APPS[@]}; do
    mas lucky "${MISSING_APPS}"
done

# update existing apps
mas upgrade

# sort apps.txt file
UUID=$(uuidgen)
sort "${BASEDIR}"/apps.txt > /tmp/"${UUID}"
mv /tmp/"${UUID}" "${BASEDIR}"/apps.txt