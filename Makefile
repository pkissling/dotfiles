DIR := ${CURDIR}
DOTFILES = .gitconfig .zshrc .ssh

# will only create new symlinks!
create_only:
	$(foreach var,$(DOTFILES),ln -s ${DIR}/$(var) ${HOME};)

# will overwrite existing symlinks
overwrite_symlinks:
	$(foreach var,$(DOTFILES),test -L ${HOME}/$(var) && ln -sf ${DIR}/$(var) ${HOME};)