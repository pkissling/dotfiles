#!/usr/bin/env bash
set -ex

# Allow sudo to use Touch ID
if ! grep -q "pam_tid.so" "/etc/pam.d/sudo"; then
    sudo sed -i '' '3i\
auth       sufficient     pam_tid.so
' "/etc/pam.d/sudo"
fi
