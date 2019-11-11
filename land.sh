#!/bin/sh

## Homebrew インストール
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

cp zsh/zshrc.zsh ~/.zshrc
cp zsh/starship.toml ~/.config/starship.toml
cp gitfile/gitconfig ~/.gitconfig
cp gitfile/gitmessage ~/.gitmessage
cp brew/Brewfile ~/.Brewfile
cp hyper.js ~/.hyper.js

## brewfile に書いたソフトウェアたちをインストール
brew bundle --global 
brew bundle cleanup

## SpaceVim インストール
curl -sLf https://spacevim.org/install.sh | bash

## zplugin インストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
