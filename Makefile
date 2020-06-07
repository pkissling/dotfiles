.PHONY: brew cask git hyper nvim sdkman ssh vscode zsh
default: .PHONY

brew:
	@chmod +x brew/install.sh
	@./brew/install.sh

cask:
	@chmod +x cask/install.sh
	@./cask/install.sh

git:
	@ln -sfv ${CURDIR}/git/.gitconfig ${HOME}
	@ln -sfv ${CURDIR}/git/.gitignore ${HOME}

hyper:
	@ln -sfv ${CURDIR}/hyper/.hyper.js ${HOME}

neovim:
	@ln -sfv ${CURDIR}/nvim/init.vim ${HOME}/.config/nvim/
	@chmod +x nvim/install.sh
	@./nvim/install.sh

sdkman:
	@chmod +x sdkman/install.sh
	@./sdkman/install.sh

ssh:
	@ln -sfv ${CURDIR}/ssh/ ${HOME}/.ssh

vscode:
	@ln -sfv ${CURDIR}/vscode/keybindings.json ${HOME}/Library/Application\ Support/Code/User/keybindings.json
	@ln -sfv ${CURDIR}/vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json
	@chmod +x vscode/install.sh
	@./vscode/install.sh

zsh:
	@ln -sfv ${CURDIR}/zsh/.zshrc ${HOME}
	@ln -sfv ${CURDIR}/zsh/.p10k.zsh ${HOME}
	@chmod +x zsh/install.sh
	@./zsh/install.sh
