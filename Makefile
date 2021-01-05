.PHONY: brew git gpg hyper nvim sdkman ssh starship vscode zsh
default: .PHONY

brew:
	@chmod +x brew/install.sh
	@./brew/install.sh

git:
	@chmod +x git/install.sh
	@./git/install.sh

gpg:
	@chmod +x gpg/install.sh
	@./gpg/install.sh

hyper:
	@chmod +x hyper/install.sh
	@./hyper/install.sh

nvim:
	@chmod +x nvim/install.sh
	@./nvim/install.sh

sdkman:
	@chmod +x sdkman/install.sh
	@./sdkman/install.sh

ssh:
	@chmod +x ssh/install.sh
	@./ssh/install.sh

starship:
	@chmod +x starship/install.sh
	@./starship/install.sh

vscode:
	@chmod +x vscode/install.sh
	@./vscode/install.sh

zsh:
	@chmod +x zsh/install.sh
	@./zsh/install.sh
