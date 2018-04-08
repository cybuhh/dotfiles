#!/usr/bin/env bash

if [[ "$OSTYPE" != "darwin"* ]]; then
	return;
fi

export CLICOLOR=1
alias flush-dns="sudo killall -HUP mDNSResponder"
alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias stree="/Applications/SourceTree.app/Contents/Resources/stree"
alias qnapi="/Applications/QNapi.app/Contents/MacOS/QNapi -c"

battery() {
	ioreg -c AppleBluetoothHIDKeyboard | grep 'BatteryPercent\" =' | awk '{ print "Keyboard battery level: " $NF "%" }'
	ioreg -c BNBMouseDevice | grep 'BatteryPercent\" =' | awk '{ print "Mouse battery level: " $NF "%" }'
}

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

# shellcheck disable=SC2142
alias github-open="git remote -v | head -1 | awk '{print \$2}' | tr ':' '/' | sed -E 's/.+@/https:\/\//;s/\.git//' | xargs open"
# shellcheck disable=SC2142
alias travis-open="git remote -v | head -1 | awk '{print \$2}' | tr ':' '/' | sed -E 's/.+@/https:\/\//;s/\.git//;s/github/travis/' | xargs open"
