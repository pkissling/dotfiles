DIR := ${CURDIR}
DOTFILES = .gitconfig .zshrc .ssh .p10k.zsh .vimrc


default: symlinks brew cask zsh vim

symlinks:
	$(foreach var,$(DOTFILES),ln -sf ${DIR}/$(var) ${HOME};)

brew:
	chmod +x brew.sh
	./brew.sh

cask:
	chmod +x cask.sh
	./cask.sh

zsh:
	chmod +x zsh.sh
	./zsh.sh

vim:
	chmod +x vim.sh
	./vim.sh

sdkman:
	chmod +x sdkman.sh
	./sdkman.sh

