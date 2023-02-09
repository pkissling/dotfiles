#!/usr/bin/env bash
set -ex

# install and update rustup
rustup-init -y
rustup update

# install all creates defined in crates.txt
while read -r CRATE; do
  cargo install $CRATE
done < rust/crates.txt
