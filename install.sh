#!/bin/sh
set -e

if [[ ! -d $HOME/dotfiles ]]; then
  git clone git@github.com:dhruvrajvanshi/dotfiles.git $HOME/dotfiles
fi

cd $HOME/dotfiles
git pull
cd -

mkdir -p $HOME/.config/nvim

if [[ ! -L $HOME/.zshrc ]]; then
  ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
fi

if [[ ! -L $HOME/.config/nvim/init.lua ]]; then
  ln -s $HOME/dotfiles/init.lua $HOME/.config/nvim/init.lua
fi
