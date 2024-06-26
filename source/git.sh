#!/usr/bin/env bash

alias git-add-selective='git add -p'
alias git-autocommit='git add -A && git commit -m "$(curl -sS http://whatthecommit.com/index.txt)" && git push'
alias git-branch-rename='!f() { git push origin :$(git branch --show-current) && git branch -m $1 && git push origin $1 && git push origin -u $1; };f'
alias git-c='git commit -m'
alias git-clean="git clean -d -f ."
alias git-commit-again="git add -A && git commit --amend --no-edit"
alias git-commit-all='git add -A && git commit -m'
alias git-commits-waiting='git log origin/master..master'
alias git-log-oneline='git log --pretty=oneline --abbrev-commit'
alias git-master='git fetch -p && (git checkout master || git checkout main) && git pull'
alias git-push-force-with-lease="git push --force-with-lease"
alias git-branch-remove-merged='git fetch -p && git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -d'
alias git-rebase='git fetch -p && git rebase -i origin/master'
alias git-rebuid='git commit -am "rebuild" --allow-empty'
alias git-reset='git reset --hard HEAD'alias git-submodule-update="git fetch && git pull && git submodule update -f --init --recursive"

function git-set-details() {
  git config user.name "$1" && git config user.email "$2"
}

function git-set-details-github() {
  git config user.name "cybuhh" && git config user.email "cybuhh@users.noreply.github.com"
}

function git-is-file-changed() {
    git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD | grep --quiet "$1"
}

alias git-push-force-with-lease='test $(git branch --show-current) != master && git push --force-with-lease'
alias git-rebase-master='test $(git branch --show-current) != master && git fetch -p && git rebase -i origin/master'

# stdout=$(git-scan-changes) && test -z "$stdout" || osascript -e "display notification \"$stdout\" with title \"git\" sound name \"purr\""
function git-scan-changes() {
  cwd=$PWD
  # shellcheck disable=SC2044
	for project in $(find . -type d -name .git 2> /dev/null) ; do
	  cd "$cwd/$project/.." || return
	  result=()
	  if [[ $(git status -s 2> /dev/null) ]]; then
  	  result+=('unstaged files')
	  fi
	  if [[ $(git diff --cached 2> /dev/null) ]]; then
  	  result+=('uncommited changes')
    fi
	  if [[ $(git log origin/master..master 2> /dev/null) ]]; then
  	  result+=('not pushed commits')
	  fi

	  if [ ${#result[@]} -gt 0 ]; then
      local IFS="," ; echo -e "${project/\/.git/} ${result[*]}" | sed -e 's/,/, /g'
	  fi
	done
  cd "$cwd" || return
}

function git-log-since() {
  authors=""
  for author in $(git config --global user.authors); do
    authors += " --author=$author"
  done;
  GIT_DIR=$1 git log --since=yesterday --pretty=oneline $authors
}

function git-standup() {
  GIT_WORKSPACE=$(git config --global dir.workspace)
  if [ -z "$GIT_WORKSPACE" ]; then
    echo 'Please set dir.workspace first with `git config --global dir.workspace $PATH_TO_WORKSPACE`'
  else
    for FOLDER in `find "$GIT_WORKSPACE" -type d -name '.git'`; do
      GIT_DIR=$FOLDER git fetch > /dev/null 2>&1
      if [ -n "$(git-log-since $FOLDER)" ]; then
        echo repo: "$FOLDER"
        git-log-since $FOLDER
      fi
    done
  fi
}
