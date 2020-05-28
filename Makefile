DIR := ${CURDIR}

defaults: symlinks brew cask zsh vim sdkman

symlinks:
	ln -sf ${DIR}/git/.gitconfig ${HOME}
	ln -sf ${DIR}/ssh/.ssh ${HOME}
	ln -sf ${DIR}/vim/init.vim ${HOME}/.config/nvim/
	ln -sf ${DIR}/vsc/keybindings.json ${HOME}/Library/Application\ Support/Code/User/keybindings.json
	ln -sf ${DIR}/vsc/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json
	ln -sf ${DIR}/zsh/.zshrc ${HOME}
	ln -sf ${DIR}/zsh/.p10k.zsh ${HOME}

brew:
	chmod +x scripts/brew.sh
	./scripts/brew.sh

cask:
	chmod +x scripts/cask.sh
	./scripts/cask.sh

sdkman:
	chmod +x scripts/sdkman.sh
	./scripts/sdkman.sh

vim:
	chmod +x scripts/vim.sh
	./scripts/vim.sh

zsh:
	chmod +x scripts/zsh.sh
	./scripts/zsh.sh