.PHONY: brew git gpg hyper nvim sdkman ssh starship vscode zsh
default: .PHONY

bootstrap:
	# ln will fail if repo was already checked out in ~/dotfiles 
	@ln -sfv $(shell pwd -P) ${HOME} || true
ifeq (,$(wildcard ${HOME}/dotfiles/.profile))
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

hyper: bootstrap brew
	@chmod +x hyper/install.sh
	@./hyper/install.sh

nvim: bootstrap brew
	@chmod +x nvim/install.sh
	@./nvim/install.sh

rust: bootstrap brew
	@rustup update

sdkman: bootstrap
	@chmod +x sdkman/install.sh
	@./sdkman/install.sh

ssh: bootstrap
	@chmod +x ssh/install.sh
	@./ssh/install.sh

starship: bootstrap brew
	@chmod +x starship/install.sh
	@./starship/install.sh

vscode: bootstrap brew
	@chmod +x vscode/install.sh
	@./vscode/install.sh

zsh: bootstrap brew
	@chmod +x zsh/install.sh
	@./zsh/install.sh

