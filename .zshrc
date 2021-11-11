
# Completion
autoload -U compinit
compinit

zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

export PS1="%F{green}%B
%~
%F{blue}› %f%b"

if which nvim; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"

alias tf=terraform


if [[ -f ~/.cargo/env ]]; then
    source ~/.cargo/env
fi


