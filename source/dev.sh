#!/usr/bin/env bash

mongo-url() {
  URL=$(echo "$1" | sed -e 's/mongodb:\/\//-u /;s/:/ -p /;s/\@/ /')
	mongo "$URL"
}

alias foreman-supervisor='foreman run supervisor -e node,js,env,yaml,yml,css'
