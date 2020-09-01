#!/usr/bin/env bash
BASEDIR=$(dirname "$0")

# install apps
while read -r APP
do
    mas install "$APP"
done < "${BASEDIR}"/apps.txt
