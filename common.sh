DOTFILES_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
alias dotfiles-commit='cd $DOTFILES_PATH && (echo -e "Please enter commit message: \c"; read MSG ; git commit -m "$MSG") ; cd - > /dev/null'
alias dotfiles-push='cd $DOTFILES_PATH; git push'

