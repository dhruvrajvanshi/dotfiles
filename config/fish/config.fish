if status is-interactive
    # Commands to run in interactive sessions can go here
end

export EDITOR=nvim

if test -d ~/.cargo
  fish_add_path ~/.cargo/bin
end

function fish_prompt
    set -l last_status $status
    # Prompt status only if it's not 0
    set -l stat

    if test $last_status -ne 0
      set arrow_color $fish_color_error
    else
      set arrow_color "blue"
    end

    set -l vcs_prompt (\
      fish_vcs_prompt \
      | string sub --start 3 --end -1\
      | string shorten --max 16\
    )
    string join '' \
      \n \
      (set_color $fish_color_cwd) (prompt_pwd) \
      (set_color purple) " ($vcs_prompt)" \
      \n \
      (set_color $arrow_color) '› '
end

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias h="history"
alias g="git"


alias ls "eza"
alias l="ls"
alias ll="ls -l -h"

if test -d /opt/homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"
end

set -gx PATH "$HOME/.local/bin" $PATH
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
