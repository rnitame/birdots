SHELL=/bin/zsh

.PHONY: git
git:
	if [ ! -d ${HOME}/.config/git ]; then mkdir -p ${HOME}/.config/git; fi
	ln -s -f ${PWD}/gitfile/gitconfig ${HOME}/.config/git/gitconfig

.PHONY: hyper
hyper:
	if [ ! -d ${HOME}/.config/hyper ]; then mkdir -p ${HOME}/.config/hyper; fi
	ln -s -f ${PWD}/hyper/hyper.js ${HOME}/.config/hyper/hyper.js

.PHONY: spacevim
spacevim:
	if [ ! -d ${HOME}/.config/spacevim ]; then mkdir -p ${HOME}/.config/spacevim; fi
	ln -s -f ${PWD}/vim/space_vim.toml ${HOME}/.config/spacevim/space_vim.toml

.PHONY: brew
brew:
	sh brew/install.sh
	brew tap Homebrew/bundle
	brew bundle --file "brew/Brewfile"

.PHONY: zsh
zsh:
	mkdir -p ${HOME}/.zsh
	ln -sf ${PWD}/zsh/.zshenv ${HOME}/.zsh/.zshenv
	if [ ! -e ${HOME}/.zsh/.zshenv.local ]; then ln -sf ${PWD}/zsh/.zshenv.local ${HOME}/.zsh/.zshenv.local; fi
	ln -sf ${PWD}/zsh/.zshrc ${HOME}/.zsh/.zshrc
	if [ ! -e ${HOME}/.zsh/.zshrc.local ]; then ln -sf ${PWD}/zsh/.zshrc.local ${HOME}/.zsh/.zshrc.local; fi
	ln -sf ${PWD}/zsh/.zprofile ${HOME}/.zsh/.zprofile
	if [ ! -e ${HOME}/.zsh/.zprofile.local ]; then ln -sf ${PWD}/zsh/.zprofile.local ${HOME}/.zsh/.zprofile.local; fi

.PHONY:	starship
starship:
	curl -sS https://starship.rs/install.sh | sh -s -- -y

.PHONY: starship-conf
starship-conf:
	if [ ! -d ${HOME}/.config ]; then mkdir -p ${HOME}/.config; fi
	ln -s -f ${PWD}/zsh/starship.toml ${HOME}/.config/starship.toml

.PHONY: pre
pre:
	if [ ! -d /usr/local/bin ]; then sudo mkdir -p /usr/local/bin; fi

.PHONY: conf
conf: git hyper starship-conf spacevim zsh

.PHONY: all
all: pre conf brew starship