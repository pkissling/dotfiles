# Plugins
plugins=(
  aws
  brew
  docker
  docker-compose
  git
  git-auto-fetch
  terraform
  zoxide
)

# init zsh
export ZSH=~/.oh-my-zsh

# configure zsh (must be set before sourcing oh-my-zsh)
export DISABLE_UPDATE_PROMPT=true
export DISABLE_AUTO_UPDATE=true
export DISABLE_MAGIC_FUNCTIONS=true
export HYPHEN_INSENSITIVE=true
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

source $ZSH/oh-my-zsh.sh

# zplug
export ZPLUG_HOME="${HOMEBREW_PREFIX}"/opt/zplug
source $ZPLUG_HOME/init.zsh

# zsh-autosuggestions
source "${HOMEBREW_PREFIX}"/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
source "${HOMEBREW_PREFIX}"/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# brew
export PATH="${HOMEBREW_PREFIX}/sbin:/sbin:/usr/local/bin:$PATH"

# starship
export STARSHIP_CONFIG="${HOME}/.starship/starship.toml"
eval "$(starship init zsh)"

# mise
eval "$(${HOMEBREW_PREFIX}/bin/mise activate zsh)"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"

# bat
export BAT_STYLE="changes,header"
export BAT_THEME="Nord"

# atuin
eval "$(atuin init zsh)"

# tools
export EDITOR="nvim" # vim
export GPG_TTY=$(tty) # gpg

# kubecontext
function kx() {
  if [ "$#" -ne 1 ]; then
    kubectx
  else
    kubectx $(kubectx | grep -i "$@" | head -n1)
  fi
}

function ide() {
  local ide_bin=$(echo 'nvim\nzed\nidea\ncode\ncursor' | fzf)
  [ -z "$ide_bin" ] && return
  local folder=$(find ~/coding -maxdepth 3 -type d -not -path '*/\.*' | fzf)
  [ -z "$folder" ] && return
  eval "${ide_bin} ${folder}"
}

# set gpg path dynamically depending on $HOMEBREW_PREFIX
export GIT_CONFIG_COUNT=1
export GIT_CONFIG_KEY_0="gpg.program" GIT_CONFIG_VALUE_0="${HOMEBREW_PREFIX}/bin/gpg"

# Aliases (must be one of the last commands to overwrite zsh aliases)
alias cat="bat"
alias cd="z"
alias g="git"
alias json="pbpaste | jq '.'"
alias k="kubectl"
alias l="ls -la"
alias ls="eza"
alias up="cd ${HOME}/dotfiles && git pull --rebase origin master && make"

# source usage specific configuration
source ~/.zshrc_profile_specific
