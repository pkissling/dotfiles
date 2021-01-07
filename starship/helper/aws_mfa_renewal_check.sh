#!/usr/bin/env bash

if [ "$(cat "${HOME}"/dotfiles/.profile)" != "work" ]; then
    # show icon only for work profile
    exit 1;
fi

CURRENT_EXPIRATION=$(cat "$HOME"/.aws/credentials.*-mfa-expiration)
CURRENT_EXPIRATION_IN_SECONDS=$(gdate -d "$CURRENT_EXPIRATION" +%s)
NOW_IN_SECONDS=$(gdate +%s)
REMAINING_VALIDILITY_IN_MINUTES=$(( (CURRENT_EXPIRATION_IN_SECONDS - NOW_IN_SECONDS) / 60 ))

if [ "${REMAINING_VALIDILITY_IN_MINUTES}" -ge 30 ]; then
    # credentials are still valid
    exit 1;
else
    # credentials invalid
    exit 0;
fi
