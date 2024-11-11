SHELL=/bin/zsh

.PHONY: git
git:
	ln -s -f ${PWD}/gitfile/gitconfig ${HOME}/.gitconfig
	@echo git phony done

.PHONY: hyper
hyper:
	ln -s -f ${PWD}/hyper/hyper.js ${HOME}/.hyper.js
	@echo hyper phony done

.PHONY: vim
vim:
	sh vim/install.sh
	if [ ! -d ${HOME}/.SpaceVim.d ]; then mkdir -p ${HOME}/.SpaceVim.d; fi
	ln -s -f ${PWD}/vim/space_vim.toml ${HOME}/.SpaceVim.d/init.toml
	@echo vim phony done

.PHONY: karabiner 
karabiner:
	if [ ! -d ${HOME}/.config/karabiner ]; then mkdir -p ${HOME}/.config/karabiner; fi
	ln -s -f ${PWD}/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json
	@echo karabiner phony done

.PHONY: brew
brew:
	sh brew/install.sh
	brew tap Homebrew/bundle
	cp brew/Brewfile ~/.Brewfile
	brew bundle --file="~/.Brewfile" 
	@echo brew phony done

.PHONY: zsh
zsh:
	mkdir -p ${HOME}/.zsh
	ln -sf ${PWD}/zsh/.zshenv ${HOME}/.zshenv
	ln -sf ${PWD}/zsh/.zshrc ${HOME}/.zshrc
	ln -sf ${PWD}/zsh/.zprofile ${HOME}/.zprofile
	sh zsh/install.sh
	@echo zsh phony done

.PHONY:	starship
starship:
	curl -sS https://starship.rs/install.sh | sh -s -- -y
	@echo starship phony done

.PHONY: starship-conf
starship-conf:
	if [ ! -d ${HOME}/.config ]; then mkdir -p ${HOME}/.config; fi
	ln -s -f ${PWD}/zsh/starship.toml ${HOME}/.config/starship.toml
	@echo starship-conf phony done

.PHONY: language
language:
	sh language/install.sh

.PHONY: pre
pre:
	if [ ! -d /usr/local/bin ]; then sudo mkdir -p /usr/local/bin; fi
	@echo pre phony done

.PHONY: conf
conf: git hyper starship-conf karabiner

.PHONY: all
all: pre brew vim zsh conf starship language
