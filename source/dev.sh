#!/usr/bin/env bash

alias foreman-supervisor='foreman run supervisor -e node,js,env,yaml,yml,css'

# mongodb://user:pass@host:port/db_name
function mongo-url() {
  PARAMS=($(echo "$1" | sed -e 's/mongodb:\/\//-u /;s/:/ -p /;s/\@/ /'))
  mongo "${PARAMS[@]}"
}

# redis://user:pass@host:port
function redis-cli-url() {
  PARAMS=($(echo "$1" | sed -e 's/redis:\/\/[^:]*:/ -a /;s/\@/ -h /;s/:/ -p /;s/-a  -h/-h/'))
  redis-cli "${PARAMS[@]}"
}

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
          ln -s "$NVM_DIR/versions/node/$(nvm version default)" "$NVM_DIR/versions/node/default"
		      ;;
      esac

      read -r -n 1 -p "Do you want to remove node version $currentVersion? [Y/n]" input
      case $input in
        [yY][eE][sS]|[yY])
          echo "Removing $currentVersion"
          nvm uninstall "$currentVersion"
		      ;;
      esac
    fi
  fi
}
