mongo-url() {
	mongo $(echo $1 | sed -e 's/mongodb:\/\//-u /;s/:/ -p /;s/\@/ /')
}

alias foreman-supervisor='foreman run supervisor -e node,js,env,yaml,yml'
