#!/usr/bin/env bash

alias git-autocommit='git add -A && git commit -m "$(curl -sS http://whatthecommit.com/index.txt)" && git push'
alias git-commits-waiting='git log origin/master..master'
alias git-log-oneline='git log --pretty=oneline --abbrev-commit'
alias git-master='git fetch -p && git checkout master && git pull'
alias git-rebase='git fetch -p && git rebase -i origin/master'
alias git-rebuid='git commit -am "rebuild" --allow-empty'
alias git-reset='git reset --hard HEAD'
alias git-submodule-update="git fetch && git pull && git submodule update -f --init --recursive"

function git-set-details() {
  git config user.name "$1" && git config user.email "$2"
}

function git-set-details-github() {
  git config user.name "cybuhh" && git config user.email "cybuhh@users.noreply.github.com"
}

function git-is-file-changed() {
    git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD | grep --quiet "$1"
}

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

function git-standup() {
  git_workspace=$(git config --global dir.workspace)
  if [ -z $git_workspace ]; then
    echo 'Please set dir.workspace first with `git config --global dir.workspace $PATH_TO_WORKSPACE`'
  else
    for folder in `find $git_workspace -type d -name '.git'`; do
      echo repo: $folder
      GIT_DIR=$folder git fetch > /dev/null 2>&1
      GIT_DIR=$folder git log --since=2.weeks --author=cybuhh --author=matcybur --author=mateusz.cyburt --pretty=oneline
    done
  fi
}
