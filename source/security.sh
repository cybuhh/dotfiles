#!/usr/bin/env bash

alias disable-history='unset HISTFILE'
alias find-suid='find / -user root -perm -u=s -type f 2>/dev/null'

alias auth-failure-ips="cat /var/log/auth.log | grep -oP 'failure.+rhost=\K[^\s]+' | sort | uniq"
alias auth-failure-ips-tail="tail -f /var/log/auth.log | grep --line-buffered -oP 'failure.+rhost=\K[^\s]+'"
alias nextcloud-logs-failure='docker container ls | grep nginx-proxy_web | cut -d " " -f 1 | xargs -I % docker container logs -f % | grep -iv --line-buffered uptime | grep --line-buffered -E \"\\s[4,5][0-9]{2}\\s'


# bash v3 compatible - no assoc arrays
# $1 - type_to_clean
# bash v3 compatible - no assoc arrays
# $1 - type_to_clean
cleanup() {
  IFS=$'\n'

  if [ $# -eq 0 ]; then
    CACHE_TYPES=()
    for CACHE_PATH in $(cat "$DOTFILES_PATH/config/cache_paths"); do
      CACHE_TYPES+="$(echo $CACHE_PATH | sed -e 's/;.*//') "
    done

    echo "Please provide cache type to clean"
    echo Available types: all "${CACHE_TYPES[@]}"
  else
    for CACHE_PATH in $(cat "$DOTFILES_PATH/config/cache_paths"); do
      CURRENT_CACHE_TYPE=$(echo $CACHE_PATH | sed -e 's/;.*//')
      CURRENT_CACHE_PATH_LIST=$(echo $CACHE_PATH | sed -e 's/.*;//' | sed -e "s/~/${HOME//\//\\/}/g")
      if [[ "$1" == "all"  || "$1" == "$CURRENT_CACHE_TYPE" ]]; then
        echo $CURRENT_CACHE_PATH_LIST | tr " " "\n" | while read CURRENT_CACHE_PATH; do
          echo "Cleaning $CURRENT_CACHE_TYPE $CURRENT_CACHE_PATH"
          rm -rf $CURRENT_CACHE_PATH
          test -d $CURRENT_CACHE_PATH || echo ok
        done
      fi
    done
  fi

  unset IFS
}

alias clean-exif='brewCmd exiftool && exiftool -all= -overwrite_original_in_place'

alias nmap-scripts='ls -1 /usr/local/share/nmap/scripts'

function randomize-mac() {
  if [ $# -gt 0 ]; then
    HW_ADDR=$(openssl rand -hex 6 | sed -e 's/\(..\)/\1:/g; s/.$//')
    sudo ifconfig "$1" ether "$HW_ADDR" && \
    echo New hw address for "$1" is "$HW_ADDR"
  else
    echo 'Missing parameter: interface name'
  fi
}
