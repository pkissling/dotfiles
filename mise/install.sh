#!/usr/bin/env bash
set -e

while read -r TOOL; do
  # if line ends with @default, run `mise use` instead of `mise install`
  if [[ "${TOOL}" == *@default ]]; then
    TOOL="${TOOL//@default/}"
    mise use -g "${TOOL}"
  else
    mise install "${TOOL}"
  fi
done < mise/tools.txt

# sort tools.txt file
UUID=$(uuidgen)
sort "${HOME}"/dotfiles/mise/tools.txt > /tmp/"${UUID}"
mv /tmp/"${UUID}" "${HOME}"/dotfiles/mise/tools.txt
