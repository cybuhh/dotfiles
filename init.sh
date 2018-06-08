#!/usr/bin/env bash

export DOTFILES_PATH
DOTFILES_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
export DOTFILES_VENDOR_PATH="$DOTFILES_PATH/vendor"

# shellcheck source=/dev/null
source "$DOTFILES_PATH/config/profile"
# create data path if it's missing
test -d "$DOTFILES_VENDOR_PATH" || mkdir "$DOTFILES_VENDOR_PATH"

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    # shellcheck source=source/dotfiles.sh
    . /etc/os-release
    OS_NAME=$NAME
    OS_VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS_NAME=$(lsb_release -si)
    OS_VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    # shellcheck source=source/dotfiles.sh
    . /etc/lsb-release
    OS_NAME=$DISTRIB_ID
    OS_VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS_NAME=Debian
    OS_VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS_NAME=$(uname -s)
    OS_VER=$(uname -r)
fi

export OS_NAME
export OS_VER

# add ssh keys
ssh-add -l > /dev/null || ssh-add > /dev/null

function backup-file-name {
  CUR_DATE=$(date +"%Y%m%d%H%M%S")
  echo "$1.$CUR_DATE"
}

function backup {
  NEW_FILE=$(backup-file-name "$1")
  type "$1" >/dev/null 2>&1 && cp -rf "$1" "$NEW_FILE"
}

function copy-with-backup {
    if [ -f "$2" ]; then
        NEW_FILE=$(backup-file-name "$2")
        type "$2" >/dev/null 2>&1 && mv "$2" "$NEW_FILE"
    else
        FOLDER=$(dirname "$2")
        mkdir -p "$FOLDER"
    fi
    cp "$1" "$2"
}

function symlink-with-backup {
    backup "$2"
    PARENT_DIR=$(dirname "$2")
    test -d "$PARENT_DIR" || mkdir -p "$PARENT_DIR"
    ln -sF "$1" "$2"
}

function sourceIfExist() {
    # shellcheck source=source/dotfiles.sh
    test -f "$1" && source "$1"
}

function brewCmd() {
  type "$1" > /dev/null 2>&1 || (echo -e "$1 missing, \nuse: brew install $1" && false)
}
sourceIfExist "$DOTFILES_VENDOR_PATH/liquidprompt/liquidprompt"
sourceIfExist "$DOTFILES_VENDOR_PATH/git/git-completion.bash"

FILES_LIST=$(find "$DOTFILES_PATH/source" -type f)

for FILE in $FILES_LIST; do
  # shellcheck source=source/dotfiles.sh
  source "$FILE";
done

function dotfiles-install {
    symlink-with-backup "$DOTFILES_PATH/config/liquidpromptrc" ~/.config/liquidpromptrc
    symlink-with-backup "$DOTFILES_PATH/config/gitignore_global" ~/.gitignore_global
    symlink-with-backup "$DOTFILES_PATH/config/youtube-dl" ~/.config/youtube-dl/config
    test -d "$DOTFILES_VENDOR_PATH/git" || mkdir -p "$DOTFILES_VENDOR_PATH/git/"
    curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > "$DOTFILES_VENDOR_PATH/git/git-completion.bash"
    # shellcheck source=source/git.sh
    source "$DOTFILES_PATH/source/git.sh"
    pushd "$DOTFILES_PATH" > /dev/null && git-submodule-update && popd > /dev/null
    echo 'Remember to load dofiles by adding to your ~/.bashrc or ~/.bash_profile or ~/.profile below line'
    echo -e "\nsource $DOTFILES_PATH/init.sh\n"
}

# autocomplete host for ssh
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
