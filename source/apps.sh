#!/usr/bin/env bash

# shellcheck disable=SC1117
sublimetext() { "open -a Sublime\ Text $1"; }
textedit() { "open -a TextEdit $1"; }
alias chrome-dws="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --disable-web-security --user-data-dir=$HOME/Library/Application\ Support/Google/Chrome/Default"
alias codium="codium --enable-proposed-api GitHub.vscode-pull-request-github"
