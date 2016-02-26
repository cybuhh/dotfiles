#!/usr/bin/env bash

export CLICOLOR=1
alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias stree="/Applications/SourceTree.app/Contents/Resources/stree"

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