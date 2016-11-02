#!/usr/bin/env bash
export LC_ALL=C
export LC_CTYPE=en_US.UTF-8
export EDITOR=vim
export VISUAL=vim
export DOTFILES_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
export DOTFILES_VENDOR_PATH="$DOTFILES_PATH/vendor"

# create data path if it's missing
test -d $DOTFILES_VENDOR_PATH || mkdir $DOTFILES_VENDOR_PATH

# add ssh keys
ssh-add -l > /dev/null || ssh-add > /dev/null

function backup {
  cp -r $1 $1.$(date +"%Y%m%d%H%M%S")
}

function copy-with-backup {
    if [ -f $2 ]; then
        mv $2 $2.$(date +"%Y%m%d%H%M%S")
    else
        mkdir -p $(dirname $2)
    fi
    cp $1 $2
}

function sourceIfExist() {
    test -f $1 && source $1
}

sourceIfExist $DOTFILES_VENDOR_PATH/liquidprompt/liquidprompt
sourceIfExist $DOTFILES_VENDOR_PATH/git/git-completion.bash

for file in $DOTFILES_PATH/source/*; do source $file; done
