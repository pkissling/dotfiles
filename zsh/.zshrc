# Plugins
plugins=(
  aws
  brew
  docker
  docker-compose
  terraform
  git
  git-auto-fetch
  git-flow
  z
)

# exports
export ZSH=~/.oh-my-zsh # zsh
export HYPHEN_INSENSITIVE=true # zsh
export DISABLE_MAGIC_FUNCTIONS=true # zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10" # zsh-autosuggestions
export BAT_STYLE="changes,header" # bat
export EDITOR="nvim" # vim
export GPG_TTY=$(tty) # gpg
export PATH="/usr/local/sbin:$PATH" # brew path
export STARSHIP_CONFIG="${HOME}/.starship/starship.toml" # starship
export ZPLUG_HOME=/usr/local/opt/zplug # zplug
export ZSH_THEME="dracula" # theme

# sources
source $ZSH/oh-my-zsh.sh # zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh # zsh-autosuggestions
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # zsh-syntax-highlighting
source $ZPLUG_HOME/init.zsh # zplug

# init
. $(brew --prefix)/etc/profile.d/z.sh # brew
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh" # sdkman
eval "$(starship init zsh)"

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

# zplug
zplug "dracula/zsh", as:theme

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
