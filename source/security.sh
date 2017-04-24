#!/usr/bin/env bash

alias disable-history='unset HISTFILE'

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
