
# Completion
autoload -U compinit
compinit

zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

export PS1="%F{blue}%B
%~
%F{%(?.green.red)}› %f%b"


if command -v nvim > /dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"

alias tf=terraform
alias ..='cd ..'
alias ...='cd ...'
alias l='ls -l'

if command -v ag; then
    export FZF_DEFAULT_COMMAND='ag -l --hidden -g ""'
fi


if [[ -f ~/.cargo/env ]]; then
    source ~/.cargo/env
fi

if [[ -f ~/local.zshrc ]]; then
    source ~/local.zshrc
fi

if [[ -d ~/.jenv ]]; then
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi

if [[ -d ~/.nvm ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

fi

if [[ -d ~/.pyenv ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

if [[ -d ~/.poetry ]]; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi


# pnpm
export PNPM_HOME="/Users/dhruv.rajvanshi@scalable.capital/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
