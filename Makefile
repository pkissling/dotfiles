defaults: symlinks brew cask zsh vim sdkman

symlinks:
	ln -sf ${CURDIR}/git/.gitconfig ${HOME}
	ln -sf ${CURDIR}/git/.gitignore ${HOME}
	ln -sf ${CURDIR}/ssh/.ssh ${HOME}/.ssh
	ln -sf ${CURDIR}/vim/init.vim ${HOME}/.config/nvim/
	ln -sf ${CURDIR}/vsc/keybindings.json ${HOME}/Library/Application\ Support/Code/User/keybindings.json
	ln -sf ${CURDIR}/vsc/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json
	ln -sf ${CURDIR}/zsh/.zshrc ${HOME}
	ln -sf ${CURDIR}/zsh/.p10k.zsh ${HOME}

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