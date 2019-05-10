#!/usr/bin/env bash

alias remove-node_modules='find . -type d -name node_modules -exec rm -r {} \;'
alias docker-cleanup='docker system prune && docker container prune && docker image prune && docker network prune && docker volume prune'

alias eslint-check-diff='clear && git diff --name-only --diff-filter=d origin/master | grep -E "js(x)?$" | xargs npx eslint'
alias foreman-supervisor='foreman run supervisor -e node,js,env,yaml,yml,css'

# mongodb://user:pass@host:port/db_name
function mongo-url() {
  # shellcheck disable=SC2207
  PARAMS=($(echo "$1" | sed -e 's/mongodb:\/\//-u /;s/:/ -p /;s/\@/ /'))
  mongo "${PARAMS[@]}"
}

# redis://user:pass@host:port
function redis-cli-url() {
  # shellcheck disable=SC2207
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

function npm-outdated() {
  IFS=$'\n'
  for line in $(npm outdated | tail -n +2 | tr -s ' '); do
    # shellcheck disable=SC2034
    IFS=' ' read -r package current wanted latest location <<<"$line"
    read -r -n 1 -p "update $package $current -> $latest ? " choice
    test "$choice" == "y" && npm install "$package@$latest" --save
  done
}

# params: port status_code
# eg: 8001 200
server() {
  # shellcheck disable=SC1117
  while true; do echo -e "HTTP/1.1 ${2:-200} OK\n\n $(date)" | nc -l 127.0.0.1 "${1:-8000}"; done
}

alias k8s-watch="watch -n 10 'kubectl -n svp-staging get pods -o wide && kubectl -n svp-beta get pods -o wide && kubectl -n svp-production get pods -o wide'"

function k8s-set-dialog-env() {
  HEIGHT=15
  WIDTH=100
  CHOICE_HEIGHT=13
}

function k8s-get-dialog-from-cmd() {
  OPTIONS=()
  for option in $($3); do
    OPTIONS+=("$option" "$option")
  done
  result=$(dialog --title "$1"  --menu "$2" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" 2>&1 >/dev/tty)
  echo $result
  test -z "$result" && return 1 || return 0
}

function k8s() {
  k8s-set-dialog-env
  namespace=$(k8s-get-dialog-from-cmd "K8s namespace" "Choose namespace" "kubectl get namespace --no-headers=true -o=custom-columns=NAME:.metadata.name") || return
  OPTIONS=('all' "get all"
           'pods' "get pods"
           'services' "get services"
           'deployments' "get deployments"
           logs logs
           scale scale
           exec exec
           describe describe)
  cmd=$(dialog --title "K8s cmd"  --menu "Choose command" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" 2>&1 >/dev/tty) || return
  case "$cmd" in
    "pods" | "all" | "services" | "deployments")
      OPTIONS=(1 "full"
               2 "names only")
      result=$(dialog --title "K8s namespace"  --menu "Choose namespace" $HEIGHT $WIDTH $CHOICE_HEIGHT "${OPTIONS[@]}" 2>&1 >/dev/tty) || return
      params=$(test "$result" == "2" && echo '-o name')
      kubectl -n "$namespace" get "$cmd" $params
      echo "kubectl -n $namespace get $cmd $params"
    ;;
    "logs")
      podName=$(k8s-get-dialog-from-cmd "K8s pod" "Choose pod" "kubectl -n "$namespace" get pods --no-headers=true -o=custom-columns=NAME:.metadata.name") || return
      kubectl -n "$namespace" logs -f "$podName"
      echo "kubectl -n $namespace logs -f $podName"
    ;;
    "scale")
      serviceName=$(k8s-get-dialog-from-cmd "K8s service" "Choose service" "kubectl -n "$namespace" get deployment.apps --no-headers=true -o=custom-columns=NAME:.metadata.name") || return
      replicas=$(dialog --title "K8s replicas"  --inputbox "Enter replicas number" $HEIGHT $WIDTH 2>&1 >/dev/tty) || return
      kubectl -n "$namespace" scale deploy "${serviceName}" --replicas="$replicas"
    ;;
    "exec")
      podName=$(k8s-get-dialog-from-cmd "K8s pod" "Choose pod" "kubectl -n "$namespace" get pods --no-headers=true -o=custom-columns=NAME:.metadata.name") || return
      kubectl -n "$namespace" exec "$podName" -i -t -- sh
      echo "kubectl -n $namespace exec $podName -i -t -- sh"
    ;;
    "describe")
      appName=$(k8s-get-dialog-from-cmd "K8s app" "Choose app" "kubectl -n "$namespace" get deployment.apps --no-headers=true -o=custom-columns=NAME:.metadata.name") || return
      podsList=$(kubectl -n "$namespace" get pods --no-headers=true -o=custom-columns=NAME:.metadata.name | grep $appName)
      podName=$(k8s-get-dialog-from-cmd "K8s pod" "Choose pod" "echo $podsList") || return
      kubectl -n "$namespace" describe pod "$podName"
      echo "kubectl -n $namespace describe pod $podName"
    ;;
  esac
}
