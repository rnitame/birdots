#!/bin/sh

cp tmux/tmux.conf ~/.tmux.conf
cp tmux/tmux.conf.osx ~/.tmux.conf.osx
cp zsh/zshrc.zsh ~/.zshrc
cp vim/vimrc ~/.vimrc
cp gitfile/gitignore ~/.gitignore
cp gitfile/gitconfig ~/.gitconfig
cp gitfile/gitmessage ~/.gitmessage

if [ "$(uname)" == 'Darwin' ]; then
    cp brew/Brewfile ~/.brewfile
fi
