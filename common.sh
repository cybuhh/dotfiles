#!/usr/bin/env bash
export LC_ALL=C
export LC_CTYPE=en_US.UTF-8
export EDITOR=vim
export VISUAL=vim
export DOTFILES_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
export DOTFILES_DATA_PATH="$DOTFILES_PATH/data"

test -d $DOTFILES_DATA_PATH || mkdir $DOTFILES_DATA_PATH

alias dotfiles-commit='cd $DOTFILES_PATH && (echo -e "Please enter commit message: \c"; read MSG ; git commit -m "$MSG") ; cd - > /dev/null'
alias dotfiles-push='cd $DOTFILES_PATH; git push'

