DIR := ${CURDIR}
DOTFILES = .gitconfig .zshrc .ssh

default:
	# will overwrite existing symlinks
	$(foreach var,$(DOTFILES),test -L ${HOME}/$(var) && ln -sf ${DIR}/$(var) ${HOME};)

	# install brew
	./brew.sh