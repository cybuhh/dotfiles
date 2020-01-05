#!/usr/bin/env bash

if [[ "$OS_NAME" != "Raspbian"* ]]; then
	return;
fi

alias display-power="vcgencmd display_power | grep 1 && vcgencmd display_power 0 || vcgencmd display_power 1"
alias temp='/opt/vc/bin/vcgencmd measure_temp'
