#!/bin/sh

cp tmux/tmux.conf ~/.tmux.conf
cp zsh/zshrc.zsh ~/.zshrc
cp vim/vimrc ~/.vimrc
cp gitfile/gitignore ~/.gitignore
cp gitfile/gitconfig ~/.gitconfig
cp gitfile/gitmessage ~/.gitmessage
cp brew/Brewfile ~/.brewfile

if [ "$(uname)" == 'Darwin' ]; then
    cp tmux/tmux.conf.osx ~/.tmux.conf.osx
fi
