# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# theme (installed via homebrew)
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# plugins (installed via homebrew)
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Plugins
plugins=(
  aws
  brew
  terraform
  git
  git-flow
  z
)

# zsh configuration
HYPHEN_INSENSITIVE=true
DISABLE_MAGIC_FUNCTIONS=true

# custom functions
function mv() {
  if [ "$#" -ne 1 ] || [ ! -f "$1" ]; then
    command mv "$@"
    return
  fi

  newfilename="$1"
  vared newfilename
  command mv -v -- "$1" "$newfilename"
}

# zsh autosuggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

# init brew
. $(brew --prefix)/etc/profile.d/z.sh
# add brew's sbin dir to PATH
export PATH="/usr/local/sbin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# oh-my-zsh
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/patrick/.sdkman"
[[ -s "/Users/patrick/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/patrick/.sdkman/bin/sdkman-init.sh"

# bat
export BAT_STYLE="changes,header"

# set default editor
export EDITOR="nvim"

# set GPG tty
export GPG_TTY=$(tty)

# Aliases (must be one of the last commands to overwrite zsh aliases)
alias cat="bat"
alias g="git"
alias l="exa -la"
alias ls="exa"
alias v="nvim"
alias vim="nvim"
