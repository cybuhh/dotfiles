#!/usr/bin/env bash

alias disable-history='unset HISTFILE'
alias find-suid='find / -user root -perm -u=s -type f 2>/dev/null'

# bash v3 compatible - no assoc arrays
# $1 - type_to_clean
clean-cache() {
  CACHE_TYPES=()
  CACHE_PATHS=()
  while read -r LINE; do
    # shellcheck disable=SC2207
    CACHE_TYPES+=($(echo "$LINE" | cut -d ';' -f 1))
    # shellcheck disable=SC2207
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
      # shellcheck disable=SC2206
      temp=( ${temp%%$1*} )
      IDX=${#temp[@]}
      PATH_TO_CLEAN=${CACHE_PATHS[$IDX]}
    fi
    echo "Cleaning path(s): $PATH_TO_CLEAN"
    rm -rf "$PATH_TO_CLEAN"
  fi
}

clean-defaults() {
   defaults delete org.videolan.vlc recentlyPlayedMedia
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

alias clean-vlc-recent='defaults write /Users/cybuhh/Library/Preferences/org.videolan.vlc.plist recentlyPlayedMedia "{}"'
