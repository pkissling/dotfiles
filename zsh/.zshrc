# Plugins
plugins=(
  aws
  brew
  docker
  docker-compose
  fzf
  git
  git-auto-fetch
  terraform
  tmux
  zoxide
)

# init zsh
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# create new tmux default session
if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default\; split-window -h \; split-window -v \; select-pane -t 0 \;
fi

# configure zsh
export DISABLE_AUTO_UPDATE=true
export DISABLE_MAGIC_FUNCTIONS=true
export HYPHEN_INSENSITIVE=true
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# zplug
export ZPLUG_HOME="${HOMEBREW_PREFIX}"/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "dracula/zsh", as:theme
if ! zplug check; then
  zplug install
fi
zplug load

# theme
ln -sf $ZPLUG_HOME/repos/dracula/zsh/dracula.zsh-theme $ZSH/themes/dracula.zsh-theme 2> /dev/null
export ZSH_THEME="dracula" # theme

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"
source "${HOMEBREW_PREFIX}"/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
source "${HOMEBREW_PREFIX}"/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# brew
export PATH=""${HOMEBREW_PREFIX}"/sbin:$PATH"

# starship
export STARSHIP_CONFIG="${HOME}/.starship/starship.toml"
eval "$(starship init zsh)"

# sdkman
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

# rust
source $HOME/.cargo/env

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s ""${HOMEBREW_PREFIX}"/opt/nvm/nvm.sh" ] && . ""${HOMEBREW_PREFIX}"/opt/nvm/nvm.sh"  # This loads nvm
[ -s ""${HOMEBREW_PREFIX}"/opt/nvm/etc/bash_completion.d/nvm" ] && . ""${HOMEBREW_PREFIX}"/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# XDG
export XDG_CONFIG_HOME="$HOME/.config"

# bat
export BAT_STYLE="changes,header"
export BAT_THEME="Dracula"

# tools
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

# kubecontext
function kx() {
  if [ "$#" -ne 1 ]; then
    kubectx
  else
    kubectx $(kubectx | grep -i "$@" | head -n1)
  fi
}

# set gpg path dynamically depending on $HOMEBREW_PREFIX
export GIT_CONFIG_COUNT=1
export GIT_CONFIG_KEY_0="gpg.program" GIT_CONFIG_VALUE_0="${HOMEBREW_PREFIX}/bin/gpg"

# save all tmux sessions in the global history
export PROMPT_COMMAND='history -a; history -r'

# Aliases (must be one of the last commands to overwrite zsh aliases)
alias cat="bat"
alias g="git"
alias json="pbpaste | jq '.'"
alias k="kubectl"
alias l="exa -la"
alias ls="exa"
alias up="cd ${HOME}/dotfiles && git pull --rebase origin && make"
alias vi="nvim"
alias vim="nvim"

# source usage specific configuration
source ~/.zshrc_user
