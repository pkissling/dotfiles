# Plugins
plugins=(
  aws
  brew
  docker
  docker-compose
  git
  terraform
)

# init zsh
export ZSH=/etc/profiles/per-user/$USER/share/oh-my-zsh
export ZSH_CACHE_DIR=~/.cache/oh-my-zsh

# configure zsh (must be set before sourcing oh-my-zsh)
export DISABLE_UPDATE_PROMPT=true
export DISABLE_AUTO_UPDATE=true
export DISABLE_MAGIC_FUNCTIONS=true
export HYPHEN_INSENSITIVE=true
export ZSH_COMPDUMP=$ZSH_CACHE_DIR/.zcompdump-$HOST
export ZSH_DISABLE_COMPFIX=true # skip oh-my-zsh's completion-security handling
skip_global_compinit=1

source $ZSH/oh-my-zsh.sh

# zsh-autosuggestions
source /etc/profiles/per-user/$USER/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
source /etc/profiles/per-user/$USER/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# PATH
export PATH="/etc/profiles/per-user/${USER}/bin:/run/current-system/sw/bin:${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:/sbin:/usr/local/bin:${HOME}/.local/bin:${PATH}"

# starship
export STARSHIP_CONFIG="${HOME}/.starship/starship.toml"
eval "$(starship init zsh)"

# mise
eval "$(mise activate zsh)"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"

# brew
export HOMEBREW_NO_ENV_HINTS=1

# bat
export BAT_STYLE="changes,header"
export BAT_THEME="Nord"

# atuin
eval "$(atuin init zsh)"

# zoxide
export _ZO_EXCLUDE_DIRS="${HOME}:${HOME}/.herdr:${HOME}/.herdr/*"
eval "$(zoxide init zsh)"

# tools
export EDITOR="nvim" # vim
export GPG_TTY=$(tty) # gpg


# Aliases (must be one of the last commands to overwrite zsh aliases)
alias vscode='code ~/dotfiles/vscode/workspaces/$(ls ~/dotfiles/vscode/workspaces | fzf)'
alias cat="bat"
alias cd="z"
alias g="git"
alias json="pbpaste | jq '.'"
alias l="ls -la"
alias ls="eza"
alias up="cd ${HOME}/dotfiles && git pull --rebase origin master && make"

# source usage specific configuration
source ~/.zshrc_profile_specific
