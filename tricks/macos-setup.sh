#!/bin/bash

default_shell='/bin/bash'

if [ "$SHELL" != "$default_shell" ]; then
  chsh -s "$default_shell"
fi

new_hostname=$(read -p 'enter new hostname: ')

if [ ! -z "$new_hostname" ]; then
	sudo scutil --set ComputerName $new_hostname
	sudo scutil --set LocalHostName $new_hostname
	sudo scutil --set HostName $new_hostname
fi


get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" |
  	grep '"tag_name":' |
  	sed -E 's/.*"([^"]+)".*/\1/'
}

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$(get_latest_release 'nvm-sh/nvm')/install.sh | bash

xcode-select --install

curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
brew install rcmdnk/file/brew-file
brew install
