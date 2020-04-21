# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# theme (installed via homebrew)
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# plugins (installed via homebrew)
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Plugins
plugins=(
  brew
  git
  git-flow
  zsh-autosuggestions
)

# Aliases
alias l="ls -lHa"

# zsh configuration
HYPHEN_INSENSITIVE=true
DISABLE_MAGIC_FUNCTIONS=true

# zsh autosuggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"

# init brew
. $(brew --prefix)/etc/profile.d/z.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
