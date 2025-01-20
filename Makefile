.PHONY: brew ghostty git gpg k9s mise nvim pam ssh starship vscode zsh
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

ghostty: bootstrap
	@chmod +x ghostty/install.sh
	@./ghostty/install.sh

git: bootstrap
	@chmod +x git/install.sh
	@./git/install.sh

gpg: bootstrap brew
	@chmod +x gpg/install.sh
	@./gpg/install.sh

k9s: bootstrap zsh
	@chmod +x k9s/install.sh
	@./k9s/install.sh

mise: bootstrap brew zsh
	@chmod +x mise/install.sh
	@./mise/install.sh

nvim: bootstrap brew
	@chmod +x nvim/install.sh
	@./nvim/install.sh

pam: bootstrap
	@chmod +x pam/install.sh
	@./pam/install.sh

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
