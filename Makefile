DIR := ${CURDIR}
DOTFILES = .gitconfig .zshrc

# will only create new symlinks!
create_only:
	$(foreach var,$(DOTFILES),ln -s ${DIR}/$(var) ${HOME}/$(var);)

overwrite_symlinks:
	$(foreach var,$(DOTFILES),test -L ${HOME}/$(var) && ln -sf ${DIR}/$(var) ${HOME}/$(var);)