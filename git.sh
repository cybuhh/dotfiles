#!/usr/bin/env bash

alias git-master='git fetch -p && git checkout master && git pull'
alias git-rebase='git fetch -p && git rebase -i origin/master'
alias git-rebuid='git commit -am "rebuild" --allow-empty'
