#!/bin/sh

cp zsh/zshrc.zsh ~/.zshrc
cp zsh/starship.toml ~/.config/starship.toml
cp gitfile/gitconfig ~/.gitconfig
cp gitfile/gitmessage ~/.gitmessage
cp brew/Brewfile ~/.brewfile
cp hyper.js ~/.hyper.js

## SpaceVim インストール
curl -sLf https://spacevim.org/install.sh | bash

