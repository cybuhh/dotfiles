#!/usr/bin/env bash

alias git-commits-waiting='git log origin/master..master'
alias git-master='git fetch -p && git checkout master && git pull'
alias git-rebase='git fetch -p && git rebase -i origin/master'
alias git-rebuid='git commit -am "rebuild" --allow-empty'
alias git-submodule-update="git fetch && git pull && git submodule update -f --init --recursive"

git-is-file-changed() {
    git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD | grep --quiet "$1"
}

# stdout=$(git-scan-changes) && test -z "$stdout" || osascript -e "display notification \"$stdout\" with title \"git\" sound name \"purr\""
git-scan-changes() {
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
