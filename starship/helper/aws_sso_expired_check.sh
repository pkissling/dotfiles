#!/usr/bin/env bash
# Exit 0 (show icon) when the AWS SSO token for the `ebx` session is missing or expired.

if [ "$(cat "${HOME}"/dotfiles/.profile 2>/dev/null)" != "work" ]; then
    exit 1
fi

SSO_SESSION="ebx"
# The AWS CLI names the token cache file after the SHA1 of the sso-session name.
CACHE_FILE="${HOME}/.aws/sso/cache/$(printf '%s' "$SSO_SESSION" | shasum | cut -d' ' -f1).json"

[ -f "$CACHE_FILE" ] || exit 0

EXPIRES_AT=$(jq -r '.expiresAt // empty' "$CACHE_FILE" 2>/dev/null)
[ -n "$EXPIRES_AT" ] || exit 0

EXPIRES_AT_IN_SECONDS=$(date -j -u -f "%Y-%m-%dT%H:%M:%SZ" "$EXPIRES_AT" +%s 2>/dev/null)
[ -n "$EXPIRES_AT_IN_SECONDS" ] || exit 0

if [ "$EXPIRES_AT_IN_SECONDS" -gt "$(date +%s)" ]; then
    exit 1
fi
exit 0
