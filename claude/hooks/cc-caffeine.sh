#!/bin/sh
# macOS only: the Linux machines are always-on VMs with nothing to keep awake.
[ "$(uname -s)" = "Darwin" ] || exit 0
exec npx cc-caffeine "$1"
