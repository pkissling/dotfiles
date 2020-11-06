# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Plugins
plugins=(
  aws
  brew
  docker
  docker-compose
  terraform
  git
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

# sources
source $ZSH/oh-my-zsh.sh # zsh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme # theme (installed via homebrew)
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh # zsh-autosuggestions
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # zsh-syntax-highlighting

# init
. $(brew --prefix)/etc/profile.d/z.sh # brew
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh powerlevel10k # powerlevel10k
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh" # sdkman

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
  print -z $( history | fzf +s --tac | choose 1: )
}

# Aliases (must be one of the last commands to overwrite zsh aliases)
alias cat="bat"
alias g="git"
alias k="kubectl"
alias l="exa -la"
alias ls="exa"
alias vi="nvim"
alias vim="nvim"

# source usage specific configuration
source ~/.zshrc_user
