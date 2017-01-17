#!/usr/bin/env bash

alias kali-ip="ssh 192.168.10.21 \"sudo cat /var/log/messages | grep iptables-ping | tail -n 1 | cut -d ' ' -f 11 | sed 's/SRC=//'\""
