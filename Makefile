.PHONY: alacritty atuin brew claude eza ghostty git git-crypt gnupg k9s mise nvim ssh starship vscode zsh
default: .PHONY

bootstrap:
	# ln will fail if repo was already checked out in ~/dotfiles
	@ln -sfv $(shell pwd -P) ${HOME} || true
ifeq (,$(wildcard ${HOME}/dotfiles/.profile))
	@echo "Usage (private/work)?"
	@read line; echo $$line > ${HOME}/dotfiles/.profile
endif

alacritty: bootstrap brew
	@chmod +x alacritty/install.sh
	@./alacritty/install.sh

atuin: bootstrap zsh
	@chmod +x atuin/install.sh
	@./atuin/install.sh

brew: bootstrap
	@chmod +x brew/install.sh
	@./brew/install.sh

claude: bootstrap git-crypt
	@chmod +x claude/install.sh
	@./claude/install.sh

eza: bootstrap brew
	@chmod +x eza/install.sh
	@./eza/install.sh

ghostty: bootstrap brew
	@chmod +x ghostty/install.sh
	@./ghostty/install.sh

git-crypt: bootstrap brew
	@stash_ref=$$(git -C ${HOME}/dotfiles stash create "git-crypt unlock auto-stash"); \
	if [ -n "$$stash_ref" ]; then \
		git -C ${HOME}/dotfiles stash store -m "git-crypt unlock auto-stash" "$$stash_ref" && \
		git -C ${HOME}/dotfiles reset --hard HEAD; \
	fi; \
	git -C ${HOME}/dotfiles crypt unlock; \
	if [ -n "$$stash_ref" ]; then git -C ${HOME}/dotfiles stash pop; fi

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

zsh: bootstrap brew
	@chmod +x zsh/install.sh
	@./zsh/install.sh
