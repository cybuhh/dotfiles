#!/usr/bin/env bash

servicesFile="service-names-port-numbers.csv"
servicesFilePath="$DOTFILES_VENDOR_PATH/services"

# shellcheck disable=SC1117
alias curl-size-raw="curl -s --write-out \"%{size_download}\n\" --output /dev/null"
# shellcheck disable=SC2142,SC2139,SC2154,SC1117
alias curl-size-gzip="curl -s -H 'Accept-Encoding: gzip,deflate' --write-out \"%{size_download}\n\" --output /dev/null"

function geoip() {
  if [ $# -eq 0 ]; then
    curl "ipinfo.io/country"
  else
    curl "ipinfo.io/$1/country"
  fi
}

alias geoip-dns='geoip $(whatismydns)'

packtpub-free() {
    if [ "$1" == 'open' ]; then
        open "https://www.packtpub.com/free-learning"
    else
        DATE_FROM=$(date "+%Y-%m-%dT00:00:00.000Z")
        DATE_TO=$(date -v+1d "+%Y-%m-%dT00:00:00.000Z")
        URL="https://services.packtpub.com/free-learning-v1/offers?dateFrom=${DATE_FROM}&dateTo=${DATE_TO}"
        curl -s $URL | jq '.data[0].productId' | xargs -I {} curl -s https://static.packt-cdn.com/products/{}/summary | jq '.title'
    fi
}

#
# params: host port status_code
# eg: google.com 443
#
ping-port() {
  (echo >/dev/tcp/"$1"/"$2") &>/dev/null && echo "open" || echo "close"
}

function scan-for-rpi() {
  sudo nmap -sP $1 | awk '/^Nmap/{ipaddress=$NF}/B8:27:EB/{print ipaddress}'
}

alias show-rpi-from-arp='arp -na | grep -i b8:27:eb'

alias ssh-pass='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

alias ssl-check='f() { openssl s_client -servername ${1} -connect ${1}:${2:-443} | openssl x509 -noout -enddate; }; echo | f'

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

weather() {
    curl -4 "wttr.in/${1:-$LOCATION_CITY}"
}

weather-v2() {
    curl -4 "v2.wttr.in/${1:-$LOCATION_CITY}"
}

alias whatismyip='curl ipinfo.io/ip'
alias whatismyip-local='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d " " -f 2'
alias whatismydns="host -a google.com | grep Received | tr '#' ' ' | cut -d ' ' -f 5"

alias wifi-signal='clear; while x=1; do /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep CtlRSSI | sed -e 's/^.*://g' | xargs -I SIGNAL printf "\rRSSI dBm: SIGNAL"; sleep 0.5; done'
