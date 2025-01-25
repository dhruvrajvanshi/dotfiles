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

if [[ ! -L $HOME/.config/nvim ]]; then
  ln -s $HOME/dotfiles/config/nvim $HOME/.config/nvim
fi
