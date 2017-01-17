#!/usr/bin/env bash

alias ll='ls -al'
alias napi-find='find . -name "*.avi" -o -name "*.mpg" -o -name "*.mpeg" -o -name "*.mp4" -o -name "*.qt" -o -name "*.mkv" -o -name "*.m2v" | while read file; do test -f "${file%.*}.txt" || qnapi "$file"; done'

nvm-update() {
  if ! command -v nvm; then
    NVM_PATH=$NVM_DIR/nvm.sh
    if [ -f "$HOME/.nvm/nvm.sh" ]; then
      # shellcheck source=source/dotfiles.sh
      source "$NVM_PATH"
    else
      echo "NVM script is missing or not available in path - $NVM_PATH"
      return 1
    fi
  fi

  currentVersion=$(nvm current | sed -e 's/^v//')
  versionMajor=$(echo "$currentVersion" | cut -d '.' -f 1)
  remoteVersion=$(nvm version-remote "$versionMajor" | sed -e 's/^v//')
  if [ "$remoteVersion" != "$currentVersion" ]; then
    if nvm install "$remoteVersion" --reinstall-packages-from="$currentVersion"; then
      read -r -n 1 -p "Do you want to make $remoteVersion default? [Y/n]" input
      case $input in
        [yY][eE][sS]|[yY])
          nvm alias default "$remoteVersion"
          nvm use "$remoteVersion"
		      ;;
      esac

      read -r -n 1 -p "Do you want to remove node version $currentVersion? [Y/n]" input
      case $input in
        [yY][eE][sS]|[yY])
          nvm uninstall "$currentVersion"
		      ;;
      esac
    fi
  fi
}
