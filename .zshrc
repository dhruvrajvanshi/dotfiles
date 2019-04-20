# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd nomatch
unsetopt beep
bindkey -v

PATH=$PATH:~/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/bin/antigen.zsh

antigen use oh-my-zsh
antigen theme denysdovhan/spaceship-prompt
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git

antigen apply

