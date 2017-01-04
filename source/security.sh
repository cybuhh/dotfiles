#!/usr/bin/env bash

alias disable-history='unset HISTFILE'

# bash v3 compatible - no assoc arrays
# $1 - type_to_clean
cache-clean() {
  CACHE_TYPES=()
  CACHE_PATHS=()
  for VAL in $(cat $DOTFILES_PATH/config/cache_paths); do
    IFS=";" read -r CACHE_TYPE <<< "$VAL"
    CACHE_PATH=$(echo $VAL | cut -d ';' -f 2-)
    CACHE_TYPES+=($CACHE_TYPE)
    CACHE_PATHS+=($CACHE_PATH)
  done

  if [ $# -gt 0 ]; then
    temp=`echo ${CACHE_TYPES[@]}`
    temp=( ${temp%%$1*} )
    IDX=${#temp[@]}
    PATH_TO_CLEAN=${CACHE_PATHS[$IDX]}
  else
    PATH_TO_CLEAN=""
    for IDX in "${CACHE_PATHS[@]}"; do
      PATH_TO_CLEAN+="\"${IDX//,/ /}\" "
    done
  fi
  echo "Cleaning path(s): $PATH_TO_CLEAN"
  rm -rf "$PATH_TO_CLEAN"
}
