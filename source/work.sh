#!/usr/bin/env bash

alias kali-ip="ssh 192.168.10.21 \"sudo cat /var/log/messages | grep iptables-ping | tail -n 1 | cut -d ' ' -f 11 | sed 's/SRC=//'\""

alias log-yata-stage="ssh m323-mesos-slave-01 'tail -F /shared/svp/yata/stage/logs/*.log -q'"
alias log-yata-prod="ssh m323-mesos-slave-01 'tail -F /shared/svp/yata/prod/logs/*.log -q'"

alias log-sifter-indexer-stage="ssh m323-mesos-slave-01 'tail -F /shared/svp/sifter/stage/logs/*index*.log -q'"
alias log-sifter-indexer-prod="ssh m323-mesos-slave-01 'tail -F /shared/svp/sifter/prod/logs/*index*.log -q'"

alias log-sifter-api-stage="ssh m323-mesos-slave-01 'tail -F /shared/svp/sifter/stage/logs/*api*.log -q'"
alias log-sifter-api-prod="ssh m323-mesos-slave-01 'tail -F /shared/svp/sifter/prod/logs/*api*.log -q'"
