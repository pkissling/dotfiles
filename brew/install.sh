#!/usr/bin/env bash
set -ex
DIR="${HOME}/dotfiles/brew"
PROFILE=$(cat "${HOME}/dotfiles/.profile")

# install brew, if not installed
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Evaluating the brew shell environment
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# update brew
brew update

# upgrade packages installed via brew
brew upgrade

# apply the base Brewfile plus the active profile's extras
brew bundle --file "${DIR}/Brewfile"
brew bundle --file "${DIR}/Brewfile.${PROFILE}"

# snapshot everything currently installed (sorted, with descriptions)
brew bundle dump --describe --force --file /tmp/Brewfile.dump

# regenerate the profile file = installed packages not already tracked in base.
# auto-captures newly installed packages and auto-prunes removed ones.
# keys ignore ", trusted: true" so cosmetic dump differences don't matter.
awk '
    NR==FNR { if (/^#/ || !NF) next; k=$0; sub(/, trusted: true/, "", k); base[k]=1; next }
    /^[[:space:]]*$/ { next }
    /^#/ { comment=$0; next }
    { key=$0; sub(/, trusted: true/, "", key)
      if (!(key in base)) { if (comment) print comment; print }
      comment="" }
' "${DIR}/Brewfile" /tmp/Brewfile.dump > "${DIR}/Brewfile.${PROFILE}"

# keep the hand-curated base tidy (taps on top; comments attached to entries)
sort_brewfile() {
    local file="$1" us rs
    us=$(printf '\037'); rs=$(printf '\036')
    {
        grep "^tap" "$file" | LC_ALL="en_US.UTF-8" sort -u
        grep -v "^tap" "$file" | awk -v rs="$rs" -v us="$us" '
            /^[[:space:]]*$/ { next }
            /^#/ { buf = buf $0 rs; next }
            { print $0 us buf $0; buf = "" }
        ' | LC_ALL="en_US.UTF-8" sort -t "$us" -k1,1 | cut -d "$us" -f2- | tr "$rs" "\n"
    } > "$file.sorted" && mv "$file.sorted" "$file"
}
sort_brewfile "${DIR}/Brewfile"

# cleanup
brew cleanup
