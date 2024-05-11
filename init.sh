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
# SSH_AGENT_PID
if [ ! -z "$SSH_AUTH_SOCK" ]; then
  ssh-add -l > /dev/null || ssh-add > /dev/null 2>&1
fi

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

# $SYNC_BUCHET_PATH
# $SYNC_FILE_FOLDER
# $SYNC_FILE
function syncLatest() {
  if [ "$2/$3" -nt "$1/$3" ]; then
    test -d "$1/$3" || mkdir -p "$1"
    cp "$2/$3" "$1/$3"
  else
    cp "$1/$3"  "$2/$3"
  fi
}

function brewCmd() {
  # shellcheck disable=SC1117
  type "$1" > /dev/null 2>&1 || (echo -e "$1 missing, \nuse: brew install $1" && false)
}
#sourceIfExist "$DOTFILES_VENDOR_PATH/liquidprompt/liquidprompt"
sourceIfExist $HOME/.bashrc

sourceIfExist "/usr/local/etc/bash_completion"
sourceIfExist "$DOTFILES_VENDOR_PATH/git/git-completion.bash"

echo $PATH | grep /usr/local/bin > /dev/null || export PATH="$PATH:/usr/local/bin"

type brew >/dev/null 2>&1 && sourceIfExist $(brew --prefix)/etc/brew-wrap

FILES_LIST=$(find "$DOTFILES_PATH/source" -type f)

for FILE in $FILES_LIST; do
  # shellcheck source=source/dotfiles.sh
  source "$FILE";
done

function dotfiles-install {
    brew install bash-completion
    symlink-with-backup "$DOTFILES_PATH/config/liquidpromptrc" ~/.config/liquidpromptrc
    symlink-with-backup "$DOTFILES_PATH/config/gitignore_global" ~/.gitignore_global
    symlink-with-backup "$DOTFILES_PATH/config/youtube-dl" ~/.config/youtube-dl/config
    test -d "$DOTFILES_VENDOR_PATH/git" || mkdir -p "$DOTFILES_VENDOR_PATH/git/"
    echo "installing git-completion"
    curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > "$DOTFILES_VENDOR_PATH/git/git-completion.bash"
    echo "installing oh-my-bash"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    # shellcheck source=source/git.sh
    source "$DOTFILES_PATH/source/git.sh"
    # shellcheck disable=SC2046,SC2164
    pushd "$DOTFILES_PATH" > /dev/null && git-submodule-update && popd > /dev/null
    echo 'Recomended fonts https://github.com/powerline/fonts'
    echo 'Remember to load dofiles by adding to your ~/.bashrc or ~/.bash_profile or ~/.profile below line'
    # shellcheck disable=SC1117
    echo -e "\nsource $DOTFILES_PATH/init.sh\n"
}

# autocomplete host for ssh
# shellcheck disable=SC2046,SC2005,SC2006,SC2002,SC1117
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh

export NVM_DIR="$HOME/.nvm"
if [ -d $NVM_DIR ]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  source <(npm completion)
fi

export RVM_DIR="$HOME/.rvm"
if [ -d $RVM_DIR ]; then
  export PATH="$PATH:$RVM_DIR/bin"
fi

# Path to your oh-my-bash installation.
export OSH="$HOME/.oh-my-bash"

if [ -d $OSH ]; then
  source "$DOTFILES_PATH/config/oh-my-bash"
fi
