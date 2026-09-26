default: atuin brew claude codex eza ghostty git gnupg helix herdr hunk mise nvim ssh starship vscode zed zsh

bootstrap:
	# ln will fail if repo was already checked out in ~/dotfiles
	@ln -sfv $(shell pwd -P) ${HOME} || true
ifeq (,$(wildcard ${HOME}/dotfiles/.profile))
	@echo "Usage (private/work)?"
	@read line; echo $$line > ${HOME}/dotfiles/.profile
endif

.PHONY: atuin
atuin: bootstrap zsh
	@chmod +x atuin/install.sh
	@./atuin/install.sh

.PHONY: brew
brew: bootstrap
	@chmod +x brew/install.sh
	@./brew/install.sh

.PHONY: claude
claude: bootstrap
	@chmod +x claude/install.sh
	@./claude/install.sh

.PHONY: codex
codex: bootstrap brew
	@chmod +x codex/install.sh
	@./codex/install.sh

.PHONY: eza
eza: bootstrap brew
	@chmod +x eza/install.sh
	@./eza/install.sh

.PHONY: ghostty
ghostty: bootstrap brew
	@chmod +x ghostty/install.sh
	@./ghostty/install.sh

.PHONY: git
git: bootstrap
	@chmod +x git/install.sh
	@./git/install.sh

.PHONY: gnupg
gnupg: bootstrap brew zsh
	@chmod +x gnupg/install.sh
	@./gnupg/install.sh

.PHONY: helix
helix: bootstrap brew
	@chmod +x helix/install.sh
	@./helix/install.sh

.PHONY: herdr
herdr: bootstrap mise
	@chmod +x herdr/install.sh
	@./herdr/install.sh

.PHONY: hunk
hunk: bootstrap mise
	@chmod +x hunk/install.sh
	@./hunk/install.sh

.PHONY: mise
mise: bootstrap brew zsh
	@chmod +x mise/install.sh
	@./mise/install.sh

.PHONY: nvim
nvim: bootstrap brew
	@chmod +x nvim/install.sh
	@./nvim/install.sh

.PHONY: ssh
ssh: bootstrap brew
	@chmod +x ssh/install.sh
	@./ssh/install.sh

.PHONY: starship
starship: bootstrap brew
	@chmod +x starship/install.sh
	@./starship/install.sh

.PHONY: vscode
vscode: bootstrap brew
	@chmod +x vscode/install.sh
	@./vscode/install.sh

.PHONY: zed
zed: bootstrap brew
	@chmod +x zed/install.sh
	@./zed/install.sh

.PHONY: zsh
zsh: bootstrap brew
	@chmod +x zsh/install.sh
	@./zsh/install.sh
