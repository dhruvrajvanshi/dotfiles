if status is-interactive
    # Commands to run in interactive sessions can go here
end

export EDITOR=nvim

mise activate fish | source

function fish_prompt
    set -l last_status $status
    # Prompt status only if it's not 0
    set -l stat

    if test $last_status -ne 0
      set arrow_color $fish_color_error
    else
      set arrow_color "blue"
    end

    string join '' \
      \n \
      (set_color $fish_color_cwd) (prompt_pwd) \
      (set_color purple) (fish_vcs_prompt) \
      \n \
      (set_color $arrow_color) '› '
end

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias h="history"
alias g="git"


if type -q "eza"
  alias ls "eza"
  alias l="eza"
  alias ll="eza -l -h"
else
  alias l="ls"
  alias ll="ls -l"
end

eval "$(/opt/homebrew/bin/brew shellenv)"
