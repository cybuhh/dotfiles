#!/usr/bin/env bash

alias disable-history='unset HISTFILE'
alias find-suid='find / -user root -perm -u=s -type f 2>/dev/null'

# bash v3 compatible - no assoc arrays
# $1 - type_to_clean
cache-clean() {
  CACHE_TYPES=()
  CACHE_PATHS=()
  while read -r LINE; do
    CACHE_TYPES+=($(echo "$LINE" | cut -d ';' -f 1))
    CACHE_PATHS+=($(echo "$LINE" | cut -d ';' -f 2-))
  done <"$DOTFILES_PATH/config/cache_paths"

  if [ $# -eq 0 ]; then
    echo "Please provide cache type to clean"
    echo Available types: all "${CACHE_TYPES[@]}"
  else
    if [ "$1" == "all" ];then
      PATH_TO_CLEAN=""
      for IDX in "${CACHE_PATHS[@]}"; do
        PATH_TO_CLEAN+="\"${IDX//,/ /}\" "
      done
    else
      temp=${CACHE_TYPES[*]}
      temp=( ${temp%%$1*} )
      IDX=${#temp[@]}
      PATH_TO_CLEAN=${CACHE_PATHS[$IDX]}
    fi
    echo "Cleaning path(s): $PATH_TO_CLEAN"
    rm -rf "$PATH_TO_CLEAN"
  fi
}

defaults-clean() {
   defaults delete org.videolan.vlc recentlyPlayedMedia
}

function randomize-mac() {
  if [ $# -gt 0 ]; then
    HW_ADDR=$(openssl rand -hex 6 | sed -e 's/\(..\)/\1:/g; s/.$//')
    sudo ifconfig "$1" ether "$HW_ADDR" && \
    echo New hw address for "$1" is "$HW_ADDR"
  else
    echo 'Missing parameter: interface name'
  fi
}
