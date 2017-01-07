#!/usr/bin/env bash

export LC_ALL=C
export LC_CTYPE=en_US.UTF-8
export EDITOR=vim
export VISUAL=vim
export DOTFILES_PATH
DOTFILES_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
export DOTFILES_VENDOR_PATH="$DOTFILES_PATH/vendor"
export BASH_MAJOR=${BASH_VERSION:0:1}

# create data path if it's missing
test -d "$DOTFILES_VENDOR_PATH" || mkdir "$DOTFILES_VENDOR_PATH"

# add ssh keys
ssh-add -l > /dev/null || ssh-add > /dev/null

function backup-file-name {
  CUR_DATE=$(date +"%Y%m%d%H%M%S")
  echo "$1.$CUR_DATE"
}

function backup {
  NEW_FILE=backup-file-name "$1"
  cp -r "$1" "$NEW_FILE"
}

function copy-with-backup {
    if [ -f "$2" ]; then
        NEW_FILE=backup-file-name "$2"
        mv "$2" "$NEW_FILE"
    else
        FOLDER=$(dirname "$2")
        mkdir -p "$FOLDER"
    fi
    cp "$1" "$2"
}

function sourceIfExist() {
    # shellcheck source=source/dotfiles.sh
    test -f "$1" && source "$1"
}

sourceIfExist "$DOTFILES_VENDOR_PATH/liquidprompt/liquidprompt"
sourceIfExist "$DOTFILES_VENDOR_PATH/git/git-completion.bash"

FILES_LIST=$(find "$DOTFILES_PATH/source" -type f)

for FILE in $FILES_LIST; do
  # shellcheck source=source/dotfiles.sh
  source "$FILE";
done
