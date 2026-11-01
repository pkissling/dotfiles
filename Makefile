default: switch claude gnupg herdr hunk mise nvim ssh vscode

# the first switch installs tools the calling shell has no PATH entry for yet
export PATH := /etc/profiles/per-user/$(USER)/bin:/run/current-system/sw/bin:/opt/homebrew/bin:$(PATH)

bootstrap:
	# ln will fail if repo was already checked out in ~/dotfiles
	@ln -sfv $(shell pwd -P) ${HOME} || true
ifeq (,$(wildcard ${HOME}/dotfiles/.profile))
	@echo "Usage (private/work)?"
	@read line; echo $$line > ${HOME}/dotfiles/.profile
endif

.PHONY: switch
switch: bootstrap
	@PROFILE=$$(cat ${HOME}/dotfiles/.profile); \
	if command -v darwin-rebuild >/dev/null; then \
		sudo "$$(command -v darwin-rebuild)" switch --flake .#$$PROFILE; \
	else \
		sudo "$$(command -v nix)" run --inputs-from . nix-darwin#darwin-rebuild -- switch --flake .#$$PROFILE; \
	fi

.PHONY: claude
claude: switch
	@./claude/install.sh

.PHONY: gnupg
gnupg: switch
	@./gnupg/install.sh

.PHONY: herdr
herdr: mise
	@./herdr/install.sh

.PHONY: hunk
hunk: mise
	@./hunk/install.sh

.PHONY: mise
mise: switch
	@./mise/install.sh

.PHONY: nvim
nvim: switch
	@./nvim/install.sh

.PHONY: ssh
ssh: switch
	@./ssh/install.sh

.PHONY: vscode
vscode: switch
	@./vscode/install.sh
