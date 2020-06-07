defaults: symlinks brew cask zsh vim sdkman

symlinks:
	@ln -sfv ${CURDIR}/git/.gitconfig ${HOME}
	@ln -sfv ${CURDIR}/git/.gitignore ${HOME}
	@ln -sfv ${CURDIR}/hyper/.hyper.js ${HOME}
	@ln -sfv ${CURDIR}/ssh/.ssh ${HOME}
	@ln -sfv ${CURDIR}/nvim/init.vim ${HOME}/.config/nvim/
	@ln -sfv ${CURDIR}/vscode/keybindings.json ${HOME}/Library/Application\ Support/Code/User/keybindings.json
	@ln -sfv ${CURDIR}/vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json
	@ln -sfv ${CURDIR}/zsh/.zshrc ${HOME}
	@ln -sfv ${CURDIR}/zsh/.p10k.zsh ${HOME}

brew:
	@chmod +x scripts/brew.sh
	@./scripts/brew.sh

cask:
	@chmod +x scripts/cask.sh
	@./scripts/cask.sh

sdkman:
	@chmod +x scripts/sdkman.sh
	@./scripts/sdkman.sh

vim:
	@chmod +x scripts/nvim.sh
	@./scripts/nvim.sh

zsh:
	@chmod +x scripts/zsh.sh
	@./scripts/zsh.sh
