#!/bin/sh

git clone git@github.com:dhruvrajvanshi/dotfiles.git $HOME/dotfiles

mkdir -p $HOME/.config/nvim


ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim

