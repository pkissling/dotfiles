DIR := ${CURDIR}
DOTFILES = .gitconfig .zshrc .ssh .p10k.zsh

default:
	# will overwrite existing symlinks
	$(foreach var,$(DOTFILES),ln -sf ${DIR}/$(var) ${HOME};)

	# install brew
	chmod +x brew.sh
	./brew.sh

	# install zsh
	chmod +x zsh.sh
	./zsh.sh