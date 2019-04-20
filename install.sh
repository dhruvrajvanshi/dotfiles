#!/bin/bash
set -e
USER=$(whoami)
HOME=/home/$USER
DIR=$(pwd)

PACKAGES="git neovim vim zsh python3-pip fonts-powerline terminator"

set_up_vim() {
  sudo pip install neovim
  echo "Setting up VIM..."
  mkdir -p $HOME/.config

  if [ -f ~/.config/nvim ]
  then
    echo "~/.config/nvim exists; backing it up to ~/.config/nvim.bak..."
    mv ~/.config/nvim ~/.config/nvim.bak
    rm -rf ~/.config/nvim
  fi
  if [ -f ~/.vimrc ]
  then
    echo "~/.vimrc exists; backing it up to ~/.vimrc.bak..."
    mv ~/.vimrc ~/.vimrc.bak
    rm -rf ~/.vimrc
  fi

  echo "Installing VIM plugged..."
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  mkdir -p ~/.config/nvim
  ln -s $DIR/.vimrc $HOME/.config/nvim/init.vim

  ln -s $DIR/.vimrc $HOME/.vimrc

  npm i -g neovim

  sudo pip install --upgrade setuptools
  sudo pip install --upgrade neovim
}

install_nvm() {
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
  source ~/.bashrc
  nvm install stable
}

install_packages() {
  sudo apt install -y software-properties-common
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt install -y $PACKAGES
  install_nvm
}

set_up_zsh() {
  ln -s $PWD/.zshrc ~/.zshrc
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

set_up_terminator() {
  sh terminator.sh
}

main() {
  install_packages
  set_up_vim
  set_up_zsh
  set_up_terminator
}

main

