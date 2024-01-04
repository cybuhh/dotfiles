#!/usr/bin/env bash

if [[ "$OSTYPE" != "darwin"* ]]; then
	return;
fi

export CLICOLOR=1

alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
alias cleanup-vlc-recent='defaults write ~/Library/Preferences/org.videolan.vlc.plist recentlyPlayedMedia "{}"'
alias cleanup-qbitorrent='rm /Users/cybuhh/Library/Application\ Support/qBittorrent/logs/*'
alias cleanup-safari='killall Safari && ps -ax | grep -i com.apple.Safari.History | grep -v grep && cut -f 1 -d " " | xargs kill -9 && rm  ~/Library/Safari/History.db*'
alias cleanup-apps-history='cleanup-vlc-recent && cleanup-qbitorrent && cleanup-safari'
alias flush-dns="sudo killall -HUP mDNSResponder"
alias fcp-reset-trial='rm ~/Library/Application\ Support/.ffuserdata'
alias finder-open-icons='open /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/'
alias fix-spotlight='sudo mdutil -a -i off && sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist &&sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist && sudo mdutil -a -i on'
# shellcheck disable=SC2142,SC2139,SC2154,SC1117
alias gh-open="git remote -v | head -1 | awk '{print \$2}' | tr ':' '/' | sed -E 's/.+@/https:\/\//;s/\.git//' | xargs open"
alias jpg-watermark-filename='mogrify -fill white -undercolor "#00000080" -pointsize 50 -gravity NorthEast -annotate +10+10 %t'
alias ls-autostart='ls -al ~/Library/LaunchAgents /Library/LaunchAgents /Library/LaunchDaemons'
alias open-icons="open /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/"
alias restart-icloud="pkill -f 'Support/bird'"
# shellcheck disable=SC1117
alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias stree="/Applications/SourceTree.app/Contents/Resources/stree"
alias qnapi="/Applications/QNapi.app/Contents/MacOS/QNapi -c"
# shellcheck disable=SC2142,SC2139,SC2154,SC1117
alias travis-open="git remote -v | head -1 | awk '{print \$2}' | tr ':' '/' | sed -E 's/.+@/https:\/\//;s/\.git//;s/github/travis/' | xargs open"

function jpg-generate-thumbs() {
  THUMBS_DIR="$PWD/thumbs"
  test -d "$THUMBS_DIR" || mkdir "$THUMBS_DIR"

  for IMAGE_FILE in *.{jpg,JPG}; do
    if [ -e "$IMAGE_FILE" ]; then
      THUMB_FILE="$THUMBS_DIR/${IMAGE_FILE/.JPG/.jpg}"
      echo "converting $IMAGE_FILE" "$THUMB_FILE"
      convert "$IMAGE_FILE" -resize 600x "$THUMB_FILE"
      sleep 1
      jpg-watermark-filename "$THUMB_FILE"
    fi
  done
}

function battery() {
	ioreg -c AppleBluetoothHIDKeyboard | grep 'BatteryPercent\" =' | awk '{ print "Keyboard battery level: " $NF "%" }'
	ioreg -c BNBMouseDevice | grep 'BatteryPercent\" =' | awk '{ print "Mouse battery level: " $NF "%" }'
}

function cdr2iso {
  hdiutil convert $1 -format UDTO -o ${2/.cdr/.iso}
}

function fix-bt {
  BT_PREFERENCES_FILE=$HOME/Library/Preferences/ByHost/com.apple.Bluetooth.FA20D8E1-AC5A-552B-9BA9-0CCA4C58DE66.plist
  sudo pkill bluetoothd
  echo 'remove all BT devices'
  read
  echo 'disable BT'
  read
  echo 'restart macos then turn on BT and add all BT devices'

  mv $HBT_PREFERENCES_FILE ${BT_PREFERENCES_FILE}.bak
}

# //shellcheck disable=SC2142,SC2139,SC2154,SC1117
function gh-pr-open() {
  base_url=$(git remote -v | head -1 | awk '{print $2}' | tr ':' '/' | sed -E 's/.+@/https:\/\//;s/\.git//')
  branch=$(git rev-parse --abbrev-ref HEAD)
  open "$base_url/compare/$branch?expand=1"
}

function tor-proxy() {
	case $1 in
		"on")
			networksetup -setsocksfirewallproxy "Wi-Fi" localhost 9050
			networksetup -setsocksfirewallproxystate "Wi-Fi" on
			;;
		"off")
			networksetup -setsocksfirewallproxystate "Wi-Fi" off
			;;
	esac
	networksetup -getsocksfirewallproxy "Wi-Fi"
}


function sync-jumpdesktop() {
  SYNC_BUCKET_PATH="$SYNC_BUCKET/JumpDesktop"
  SYNC_FILE_FOLDER="$HOME/Library/Containers/com.p5sys.jump.mac.viewer/Data/Library/Application Support/Jump Desktop"
  SYNC_FILE="JDInputProfile.plist"
  syncLatest "$SYNC_BUCKET_PATH" "$SYNC_FILE_FOLDER" "$SYNC_FILE"
}

function sync-forlift() {
  SYNC_BUCKET_PATH="$SYNC_BUCKET/forklift"
  SYNC_FILE_FOLDER="$HOME/Library/Application Support/ForkLift/Favorites"
  SYNC_FILE="Favorites.json"
  syncLatest "$SYNC_BUCKET_PATH" "$SYNC_FILE_FOLDER" "$SYNC_FILE"
}
