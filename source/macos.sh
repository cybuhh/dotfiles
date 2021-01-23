#!/usr/bin/env bash

if [[ "$OSTYPE" != "darwin"* ]]; then
	return;
fi

export CLICOLOR=1
alias flush-dns="sudo killall -HUP mDNSResponder"
# shellcheck disable=SC1117
alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias stree="/Applications/SourceTree.app/Contents/Resources/stree"
alias qnapi="/Applications/QNapi.app/Contents/MacOS/QNapi -c"

battery() {
	ioreg -c AppleBluetoothHIDKeyboard | grep 'BatteryPercent\" =' | awk '{ print "Keyboard battery level: " $NF "%" }'
	ioreg -c BNBMouseDevice | grep 'BatteryPercent\" =' | awk '{ print "Mouse battery level: " $NF "%" }'
}

alias finder-open-icons='open /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/'

tor-proxy() {
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

# shellcheck disable=SC2142,SC2139,SC2154,SC1117
alias gh-open="git remote -v | head -1 | awk '{print \$2}' | tr ':' '/' | sed -E 's/.+@/https:\/\//;s/\.git//' | xargs open"
# //shellcheck disable=SC2142,SC2139,SC2154,SC1117
function gh-pr-open() {
  base_url=$(git remote -v | head -1 | awk '{print $2}' | tr ':' '/' | sed -E 's/.+@/https:\/\//;s/\.git//')
  branch=$(git rev-parse --abbrev-ref HEAD)
  open "$base_url/compare/$branch?expand=1"
}
# shellcheck disable=SC2142,SC2139,SC2154,SC1117
alias travis-open="git remote -v | head -1 | awk '{print \$2}' | tr ':' '/' | sed -E 's/.+@/https:\/\//;s/\.git//;s/github/travis/' | xargs open"

function cdr2iso {
  hdiutil convert $1 -format UDTO -o ${2/.cdr/.iso}
}

alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
alias cleanup-vlc-recent='defaults write ~/Library/Preferences/org.videolan.vlc.plist recentlyPlayedMedia "{}"'
alias fcp-reset-trial='rm ~/Library/Application\ Support/.ffuserdata'

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
