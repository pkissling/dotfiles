# Plugins
plugins=(
  aws
  brew
  docker
  docker-compose
  terraform
  git
  git-auto-fetch
  z
)

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "dracula/zsh", as:theme
if ! zplug check; then
  zplug install
fi
zplug load

# zsh
export DISABLE_AUTO_UPDATE=true
export DISABLE_MAGIC_FUNCTIONS=true
export HYPHEN_INSENSITIVE=true
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# theme
ln -sf $ZPLUG_HOME/repos/dracula/zsh/dracula.zsh-theme $ZSH/themes/dracula.zsh-theme
export ZSH_THEME="dracula" # theme

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# brew
export PATH="/usr/local/sbin:$PATH"
. $(brew --prefix)/etc/profile.d/z.sh

# starship
export STARSHIP_CONFIG="${HOME}/.starship/starship.toml"
eval "$(starship init zsh)"

# sdkman
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

# rust
source $HOME/.cargo/env

# tools
export BAT_STYLE="changes,header" # bat
export EDITOR="nvim" # vim
export GPG_TTY=$(tty) # gpg

# custom functions
# rename
function mv() {
  if [ "$#" -ne 1 ] || [ ! -f "$1" ]; then
    command mv "$@"
    return
  fi

  newfilename="$1"
  vared newfilename
  command mv -v -- "$1" "$newfilename"
}

# fzf history (https://github.com/junegunn/fzf/wiki/examples#command-history)
hist() {
  print -z $( history | fzf +s --tac -e| choose 1: )
}

# Aliases (must be one of the last commands to overwrite zsh aliases)
alias cat="bat"
alias g="git"
alias json="pbpaste | jq '.'"
alias k="kubectl"
alias l="exa -la"
alias ls="exa"
alias up="cd ${HOME}/dotfiles && git pull && make"
alias vi="nvim"
alias vim="nvim"

# source usage specific configuration
source ~/.zshrc_user
