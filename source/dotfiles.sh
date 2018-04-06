#!/usr/bin/env bash

alias dotfiles-commit='cd $DOTFILES_PATH && (echo -e "Please enter commit message: \c"; read MSG ; git commit -m "$MSG") ; cd - > /dev/null'
alias dotfiles-push='cd $DOTFILES_PATH; git push'
alias dotfiles-update='cd $DOTFILES_PATH; git fetch && git pull ; git submodule update --remote ; cd -'
alias dotfiles-reload='. $DOTFILES_PATH/init.sh'
