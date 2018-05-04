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

function nvm-update() {
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

function k8s() {
  HEIGHT=15
  WIDTH=100
  CHOICE_HEIGHT=13
  OPTIONS=(svp-staging svp-staging
           svp-beta svp-beta
           svp-production svp-production)
  namespace=$(dialog --title "K8s namespace"  --menu "Choose namespace" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" 2>&1 >/dev/tty)
  OPTIONS=('all' "get all"
           'pods' "get pods"
           'services' "get services"
           logs logs
           scale scale
           exec exec
           describe describe)
  cmd=$(dialog --title "K8s cmd"  --menu "Choose command" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" 2>&1 >/dev/tty)
  case "$cmd" in
    "pods" | "all" | "services")
      OPTIONS=(1 "full"
               2 "names only")
      result=$(dialog --title "K8s namespace"  --menu "Choose namespace" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" 2>&1 >/dev/tty)
      params=$(test "$result" == "2" && echo ' -o name' || echo '')
      kubectl -n "$namespace" get "$cmd" $params
    ;;
    "logs")
      podNames=$(kubectl -n "$namespace" get pods -o name)
      unset OPTIONS
      OPTIONS=()
      for option in $podNames; do
        OPTIONS+=("${option/pods\//}" "${option/pods\//}")
      done
      params=$(dialog --title "K8s pod"  --menu "Choose pod" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" 2>&1 >/dev/tty)
      kubectl -n "$namespace" logs -f "$params"
    ;;
    "scale")
      servicesNames=$(kubectl -n "$namespace" get deployment.apps -o name | sed 's/deployment.apps\///g')
      unset OPTIONS
      OPTIONS=()
      for option in $servicesNames; do
        OPTIONS+=("${option/services\//}" "${option/services\//}")
      done
      serviceName=$(dialog --title "K8s service"  --menu "Choose service" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" 2>&1 >/dev/tty)
      replicas=$(dialog --title "K8s replicas"  --inputbox "Enter replicas number" $HEIGHT $WIDTH 2>&1 >/dev/tty)
      kubectl -n "$namespace" scale deploy "${serviceName}" --replicas="$replicas"
    ;;
    "exec")
      podNames=$(kubectl -n "$namespace" get pods -o name)
      unset OPTIONS
      OPTIONS=()
      for option in $podNames; do
        OPTIONS+=("${option/pods\//}" "${option/pods\//}")
      done
      params=$(dialog --title "K8s pod"  --menu "Choose pod" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" 2>&1 >/dev/tty)
      kubectl -n "$namespace" exec "$params" -i -t -- sh
    ;;
    "describe")
      podNames=$(kubectl -n "$namespace" get deployment.apps -o name | sed 's/deployment.apps\///g')
      unset OPTIONS
      OPTIONS=()
      for option in $podNames; do
        OPTIONS+=("${option/pods\//}" "${option/pods\//}")
      done
      params=$(dialog --title "K8s pod"  --menu "Choose pod" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" 2>&1 >/dev/tty)
      kubectl -n "$namespace" describe pod "$params"
    ;;
  esac
}
