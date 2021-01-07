.PHONY: brew git gpg hyper nvim sdkman ssh starship vscode zsh
default: .PHONY

bootstrap:
	@ln -sfv $(shell pwd -P) ${HOME}
ifeq (,$(wildcard ${PWD}/.profile))
	@echo "Usage (private/work)?"
	@read line; echo $$line > ${HOME}/dotfiles/.profile
endif

brew: bootstrap
	@chmod +x brew/install.sh
	@./brew/install.sh

git: bootstrap
	@chmod +x git/install.sh
	@./git/install.sh

gpg: bootstrap
	@chmod +x gpg/install.sh
	@./gpg/install.sh

hyper: bootstrap
	@chmod +x hyper/install.sh
	@./hyper/install.sh

nvim: bootstrap
	@chmod +x nvim/install.sh
	@./nvim/install.sh

sdkman: bootstrap
	@chmod +x sdkman/install.sh
	@./sdkman/install.sh

ssh: bootstrap
	@chmod +x ssh/install.sh
	@./ssh/install.sh

starship: bootstrap
	@chmod +x starship/install.sh
	@./starship/install.sh

vscode: bootstrap
	@chmod +x vscode/install.sh
	@./vscode/install.sh

zsh: bootstrap
	@chmod +x zsh/install.sh
	@./zsh/install.sh

