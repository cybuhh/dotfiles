#!/usr/bin/env bash

function dotfiles-install {
    copy-with-backup "$DOTFILES_PATH/config/liquidpromptrc" ~/.config/liquidpromptrc
    copy-with-backup "$DOTFILES_PATH/config/gitignore_global" ~/.gitignore_global
    copy-with-backup "$DOTFILES_PATH/config/youtube-dl" ~/.config/youtube-dl/config
    test -d "$DOTFILES_VENDOR_PATH/git" || mkdir -p "$DOTFILES_VENDOR_PATH/git/"
    curl -s https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > "$DOTFILES_VENDOR_PATH/git/git-completion.bash"
    # shellcheck source=source/git.sh
    source "$DOTFILES_PATH/source/git.sh"
    cd $DOTFILES_PATH && git-submodule-update
    cd - > /dev/null
    echo 'Remember to load dofiles by adding to your ~/.bashrc or ~/.bash_profile or ~/.profile below line'
    echo -e "\nsource $DOTFILES_PATH/init.sh\n"
}

alias dotfiles-commit='cd $DOTFILES_PATH && (echo -e "Please enter commit message: \c"; read MSG ; git commit -m "$MSG") ; cd - > /dev/null'
alias dotfiles-push='cd $DOTFILES_PATH; git push'
alias dotfiles-update='cd $DOTFILES_PATH; git fetch && git pull ; git submodule update --remote ; cd -'
alias dotfiles-reoload='. $DOTFILES_PATH/init.sh'
