#!/usr/bin/env bash
set -ex

# install and update rustup
rustup-init -y
# shellcheck source=/dev/null
source "${HOME}"/.cargo/env
rustup update

# install all creates defined in crates.txt
while read -r CRATE; do
  # shellcheck disable=SC2046
  cargo install $(echo "${CRATE}" | xargs)
done < rust/crates.txt
