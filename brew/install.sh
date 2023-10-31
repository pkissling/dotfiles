#!/usr/bin/env bash
set -ex
USAGE=$(cat "${HOME}"/dotfiles/.profile)

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

# install packages from Brewfile
brew bundle --file "${HOME}"/dotfiles/brew/Brewfile."${USAGE}"

# create two temp files to compare delta
cat "${HOME}"/dotfiles/brew/Brewfile > /tmp/Brewfile.concat && cat "${HOME}"/dotfiles/brew/Brewfile."${USAGE}" >> /tmp/Brewfile.concat
brew bundle dump --file /tmp/Brewfile.dump --force

# identify delta (missing packages) and append to Brewfile
grep --invert-match --line-regexp --file /tmp/Brewfile.concat /tmp/Brewfile.dump >> "${HOME}"/dotfiles/brew/Brewfile."${USAGE}" || true

# sort Brewfiles (keep taps on top)
find "${HOME}"/dotfiles/brew -type f -name "Brewfile*" ! -name "*.lock.json" -print0 | while IFS= read -r -d '' file; do
    {
        grep "^tap" "$file";
        grep -v "^tap" "$file" | awk '$1' | sort;
    } > "$file.sorted" && mv "$file.sorted" "$file"
done

# cleanup
brew cleanup
