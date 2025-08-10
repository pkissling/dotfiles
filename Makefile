.PHONY: atuin brew claude eza ghostty git gnupg k9s mise nvim ssh starship vscode zed zsh
default: .PHONY

bootstrap:
	# ln will fail if repo was already checked out in ~/dotfiles
	@ln -sfv $(shell pwd -P) ${HOME} || true
ifeq (,$(wildcard ${HOME}/dotfiles/.profile))
	@echo "Usage (private/work)?"
	@read line; echo $$line > ${HOME}/dotfiles/.profile
endif

atuin: bootstrap zsh
	@chmod +x atuin/install.sh
	@./atuin/install.sh

brew: bootstrap
	@chmod +x brew/install.sh
	@./brew/install.sh

claude: bootstrap brew
	@chmod +x claude/install.sh
	@./claude/install.sh

eza: bootstrap brew
	@chmod +x eza/install.sh
	@./eza/install.sh

ghostty: bootstrap
	@chmod +x ghostty/install.sh
	@./ghostty/install.sh

git: bootstrap
	@chmod +x git/install.sh
	@./git/install.sh

gnupg: bootstrap brew zsh
	@chmod +x gnupg/install.sh
	@./gnupg/install.sh

k9s: bootstrap zsh
	@chmod +x k9s/install.sh
	@./k9s/install.sh

mise: bootstrap brew zsh
	@chmod +x mise/install.sh
	@./mise/install.sh

nvim: bootstrap brew
	@chmod +x nvim/install.sh
	@./nvim/install.sh

ssh: bootstrap
	@chmod +x ssh/install.sh
	@./ssh/install.sh

starship: bootstrap brew
	@chmod +x starship/install.sh
	@./starship/install.sh

vscode: bootstrap brew
	@chmod +x vscode/install.sh
	@./vscode/install.sh

zed: bootstrap brew
	@chmod +x zed/install.sh
	@./zed/install.sh

zsh: bootstrap brew
	@chmod +x zsh/install.sh
	@./zsh/install.sh
