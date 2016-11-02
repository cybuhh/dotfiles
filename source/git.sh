#!/usr/bin/env bash

alias git-commits-waiting='git log origin/master..master'
alias git-master='git fetch -p && git checkout master && git pull'
alias git-rebase='git fetch -p && git rebase -i origin/master'
alias git-rebuid='git commit -am "rebuild" --allow-empty'
alias git-submodule-update="git fetch && git pull && git submodule update -f --init --recursive"
git-is-file-changed() {
    git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD | grep --quiet "$1"
}
