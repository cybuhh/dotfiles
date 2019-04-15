#!/usr/bin/env bash

servicesFile="service-names-port-numbers.csv"
servicesFilePath="$DOTFILES_VENDOR_PATH/services"

#
# params: host port status_code
# eg: google.com 443
#
ping-port() {
  (echo >/dev/tcp/"$1"/"$2") &>/dev/null && echo "open" || echo "close"
}

whatportis() {

    if [ "$1" == 'update' ]; then
      mkdir -p "$servicesFilePath"
      curl -s "http://www.iana.org/assignments/service-names-port-numbers/$servicesFile" | cut -d ',' -f 1,2,3,4 > "$servicesFilePath/$servicesFile"
    	needle="$2"
    else
	   needle="$1"
    fi

    if [ -n "$needle" ]; then
    	grep -e 'Service Name' -e "^$needle," -e ",$needle," "$servicesFilePath/$servicesFile" | column -s , -t
    fi
}

test -f "$servicesFilePath/$servicesFile" || whatportis update

# shellcheck disable=SC1117
alias curl-size-raw="curl -s --write-out \"%{size_download}\n\" --output /dev/null"
# shellcheck disable=SC2142,SC2139,SC2154,SC1117
alias curl-size-gzip="curl -s -H 'Accept-Encoding: gzip,deflate' --write-out \"%{size_download}\n\" --output /dev/null"

packtpub-free() {
    URL=https://www.packtpub.com/packt/offers/free-learning;
    if [ "$1" == 'open' ]; then
        open $URL
    else
        curl -s $URL | xmllint --html --recover --xpath "//*[@class='dotd-title']/h2/text()" - 2> /dev/null | sed 's/[^0-9A-Za-z_ ,-]//g' | tr -d '\n'
    fi
}

weather() {
    curl -4 "wttr.in/${1:-$LOCATION_CITY}"
}

alias whatismyip='curl ipinfo.io/ip'
alias whatismyip-local='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d " " -f 2'
alias whatismydns="host -a google.com | grep Received | tr '#' ' ' | cut -d ' ' -f 5"

function geoip() {
  if [ $# -eq 0 ]; then
    curl "ipinfo.io/country"
  else
    curl "ipinfo.io/$1/country"
  fi
}

alias geoip-dns='geoip $(whatismydns)'

alias wifi-signal='clear; while x=1; do /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep CtlRSSI | sed -e 's/^.*://g' | xargs -I SIGNAL printf "\rRSSI dBm: SIGNAL"; sleep 0.5; done'
