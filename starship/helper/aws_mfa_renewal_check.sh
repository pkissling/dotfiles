#!/usr/bin/env bash

if [ "$(cat "${HOME}"/dotfiles/.profile)" != "work" ]; then
    # show icon only for work profile
    exit 1
fi

CURRENT_EXPIRATION=$(cat "$HOME"/.aws/credentials.*-mfa-expiration)

# Normalize date: replace +00:00 or +0000 with Z
NORMALIZED_EXPIRATION=$(echo "$CURRENT_EXPIRATION" | sed -E 's/([+-]00:00|[+-]0000)$/Z/')

# Parse CURRENT_EXPIRATION in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ
CURRENT_EXPIRATION_IN_SECONDS=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$NORMALIZED_EXPIRATION" +%s 2>/dev/null)
NOW_IN_SECONDS=$(date +%s)
REMAINING_VALIDILITY_IN_MINUTES=$(( (CURRENT_EXPIRATION_IN_SECONDS - NOW_IN_SECONDS) / 60 ))

if [ "${REMAINING_VALIDILITY_IN_MINUTES}" -ge 30 ]; then
    # credentials are still valid
    exit 1
else
    # credentials invalid
    exit 0
fi
