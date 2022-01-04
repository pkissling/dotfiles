#!/usr/bin/env bash
set -ex

# install and update rustup
rustup-init -y
rustup update

# compare list of installed crates with crates.txt and identify delta
CRATES=$(cat rust/crates.txt)
for CRATE in ${CRATES}; do
  cargo install "${CRATE}"
done
