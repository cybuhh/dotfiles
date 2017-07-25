#!/usr/bin/env bash

alias remove-node_modules='find . -type d -name node_modules -exec rm -r {} \;'
alias docker-cleanup='docker system prune && docker container prune && docker image prune && docker network prune && docker volume prune'

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
  if ! command -v nvm > /dev/null; then
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
  versionMajor=${1:-$(echo "$currentVersion" | cut -d '.' -f 1)}
  remoteVersion=$(nvm version-remote "$versionMajor" | sed -e 's/^v//')
  if [ "$remoteVersion" != "$currentVersion" ]; then
    if nvm install "$remoteVersion" --reinstall-packages-from="$currentVersion"; then
      read -r -n 1 -p "Do you want to make $remoteVersion default? [Y/n]" input
      case $input in
        [yY][eE][sS]|[yY])
          echo "Aliasing default to $remoteVersion"
          nvm alias default "$remoteVersion"
          echo "Set nvm-use $remoteVersion"
          nvm use "$remoteVersion"
          echo  "Symlinking $NVM_DIR/versions/node/$(nvm version default) to $NVM_DIR/versions/node/current"
          rm "$NVM_DIR/versions/node/current"
          ln -sf "$NVM_DIR/versions/node/$(nvm version default)" "$NVM_DIR/versions/node/current"
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

# params: port status_code
# eg: 8001 200
server() {
  while true; do echo -e "HTTP/1.1 ${2:-200} OK\n\n $(date)" | nc -l 127.0.0.1 "${1:-8000}"; done
}
