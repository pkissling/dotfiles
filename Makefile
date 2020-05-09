DIR := ${CURDIR}

default: symlinks brew cask zsh vim sdkman

symlinks:
	ln -sf ${DIR}/.gitconfig ${HOME}
	ln -sf ${DIR}/.zshrc ${HOME}
	ln -sf ${DIR}/.ssh ${HOME}
	ln -sf ${DIR}/.p10k.zsh ${HOME}
	ln -sf ${DIR}/init.vim ${HOME}/.config/nvim/
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

