#!/bin/sh

cp zsh/zshrc.zsh ~/.zshrc
cp vim/vimrc ~/.vimrc
cp gitfile/gitignore ~/.gitignore
cp gitfile/gitconfig ~/.gitconfig
cp gitfile/gitmessage ~/.gitmessage

if [ "$(uname)" == 'Darwin' ]; then
    cp brew/Brewfile ~/.brewfile
fi

if [ "$(uname)" == 'Linux' ]; then
    cp brew/Brewfile4Linux ~/.brewfile
fi
