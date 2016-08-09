#!/usr/bin/env bash

if [[ "$OSTYPE" != "darwin"* ]]; then
	return;
fi

export CLICOLOR=1
alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias stree="/Applications/SourceTree.app/Contents/Resources/stree"
alias qnapi="/Applications/QNapi.app/Contents/MacOS/QNapi -c"

battery() {
	case $1 in
		"keyboard")
			ioreg -c AppleBluetoothHIDKeyboard | grep 'BatteryPercent\" =' | awk '{ print "Keyboard battery level: " $NF "%" }'
			;;
		"mouse")
			ioreg -c BNBMouseDevice | grep 'BatteryPercent\" =' | awk '{ print "Mouse battery level: " $NF "%" }'
			;;
		*)
			echo -e "Enter one of:\n- keyboard\n- kbd\n- mouse\n- mice"
	esac
}

tor-prooxy() {
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
