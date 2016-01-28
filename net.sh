test -f "$DOTFILES_DATA_PATH/services.csv" || curl -s http://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.csv | cut -d ',' -f 1,2,3,4 > "$DOTFILES_DATA_PATH/services.csv"

getWhatportis() {
	grep -e 'Service Name' -e "^$1," -e ",$1," $DOTFILES_DATA_PATH/services.csv | column -s , -t
}

alias whatismyip='curl ipinfo.io/ip'
alias whatismyip-local='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d " " -f 2'
alias whatportis=getWhatportis
