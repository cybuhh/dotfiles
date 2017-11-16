#!/usr/bin/env bash

mkdir -p ~/.mongodb

alias mongod="mongod --dbpath=~/.mongodb"

alias server-static-python2="python -m SimpleHTTPServer"
alias server-static-python3="python3 -m http.server"
server-static-php() {
  php -S localhost:"${1:-80}"
}
server-static-ruby() {
 ruby -run -e httpd . -p"${1:-80}"
}
