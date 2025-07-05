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

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
