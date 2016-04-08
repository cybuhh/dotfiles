#!/usr/bin/env bash

servicesFile=$DOTFILES_VENDOR_PATH/services/service-names-port-numbers.csv

whatportis() {

    if [ "$1" == 'update' ]; then
        mkdir -p $DOTFILES_VENDOR_PATH/services
        curl -s http://www.iana.org/assignments/service-names-port-numbers/$(basename $servicesFile) | cut -d ',' -f 1,2,3,4 > "$servicesFile"
    	needle=$2
    else
	   needle=$1
    fi

    if [ -n "$needle" ]; then
    	grep -e 'Service Name' -e "^$needle," -e ",$needle," "$servicesFile" | column -s , -t
    fi
}

test -f "$servicesFile" || whatportis update

alias curl-size-raw="curl -s --write-out \"%{size_download}\n\" --output /dev/null"
alias curl-size-gzip="curl -s -H 'Accept-Encoding: gzip,deflate' --write-out \"%{size_download}\n\" --output /dev/null"

packtpub-free() {
    URL=https://www.packtpub.com/packt/offers/free-learning;
    if [ "$1" == 'open' ]; then
        open $URL
    else 
        echo $(curl -s $URL | xmllint --html --recover --xpath "//*[@class='dotd-title']/h2/text()" - 2> /dev/null | sed 's/[^0-9A-Za-z_ ,-]//g' | tr -d '\n')
    fi
}

weather() {
    curl -4 wttr.in/$1
}

alias whatismyip='curl ipinfo.io/ip'
alias whatismyip-local='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d " " -f 2'
