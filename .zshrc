
# Completion
autoload -U compinit
compinit

zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

export PS1="%F{green}%K{black}%B
%~
%F{blue}› %f%b"

export EDITOR=vim

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"

alias tf=terraform

source ~/.cargo/env


