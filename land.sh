#!/bin/sh

## Homebrew インストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## SpaceVim インストール
curl -sLf https://spacevim.org/install.sh | bash

## zinit インストール
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

cp zsh/zshrc.zsh ~/.zshrc
cp zsh/starship.toml ~/.config/starship.toml
cp gitfile/gitconfig ~/.gitconfig
cp gitfile/gitmessage ~/.gitmessage
cp brew/Brewfile ~/.Brewfile
cp hyper.js ~/.hyper.js
cp vim/space_vim.toml ~/.SpaceVim.d/init.toml
cp karabiner/karabiner.json ~/.config/karabiner/karabiner.json
cp vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json 

## brewfile に書いたソフトウェアたちをインストール
brew bundle --file=~/.Brewfile
brew bundle cleanup
