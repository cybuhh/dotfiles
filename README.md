# dotfiles

Add to your .profile or .bash_profile line below to load it

```source [DOTFILES_PATH]/init.sh```

## apps
 - sublimetext - open file in SublimeText
 - textedit - open file in TextEdit
 - chrome-dws - run chrome with disabled web security

## common

 - backup - copy file/folder with current date suffix

## dev

 - docker-cleanup - alias for all docker prune commands
 - eslint-check-diff - eslint - check only uncommited changes
 - foreman-supervisor - alias for 'foreman run supervisor'
 - k8s - k8s tools
 - k8s-watch - watch k8s namespaces
 - mongo-url - connect to mongo from mongo url in format mongodb://user:pass@host:port/db_name
 - npm-outdated - update outdated npm modules
 - nvm-update [major version] - update current used nodejs to newest version, alias to default,
   reinstall packages from current version and remove old nodejs version
 - redis-cli-url - connect to redis from redis url in format redis://user:pass@host:port
 - remove-node_modules - remove all node_modules folders in current directories and all sub-directories
 - server - simple netcat server, listen on given port, dump request and respond with given status code
   e.g. server 8000 200

## dotfiles

 - dotfiles-commit - commit to dotfiles repo
 - dotfiles-push - push to dotfiles repo
 - dotfiles-reload - reload dotfile scripts
 - dotfiles-update - update dotfiles repo
 - dotfiles-install - install vendors etc.

## git

 - git-autocommit - add all changed files, commit and push to origin
 - git-commits-waiting - commits waiting to be pushed
 - git-is-file-changed - check if given file was modified
 - git-log-oneline - git log in 'oneline' format
 - git-master - git fetch & checkout master & pull
 - git-rebase - git fetch & rebase to origin/master
 - git-rebuid - git rebuild (empty commit)
 - git-reset - git reset hard to HEAD
 - git-scan-changes - scan all subfolders for git repo and check for unstaged files, uncommited changes, and not pushed commits
 - git-set-details - set given username and email for current repo
 - git-set-details-github - github alias username and email for current repo 
 - git-submodule-update - git fetch and refresh all submodules

## net

 - ping-port - ping tcp port on host
 
 ```
 $ ping-port google.com 443
 close
 ```

 - curl-size-raw - get size of raw source
 
 ```
 $ curl-size-raw google.com
 258
 ```

 - curl-size-gzip - get size of gzip-ed source
 
 ```
 $ curl-size-gzip google.com
 258
 ```
 -geoip fetch fetch geo-ip for current or given ip address
 ```
 $ geoip
 DE
 ```

 ```
 $ geoip 8.8.8.8
 DE
 ```
 
 -geoip-dns - fetch geo-ip for current dns server
 ```
 $ geoip-dns
 DE
 ```
 
 - packtpub-free [open] - show/open free packtpub's book for today
 ```
 $ packtpub-free
 PhoneGap and AngularJS for Cross-platform Development
 ```

 - weather - get weather for current or defined location

 ```
 $ weather
 Weather for City: xxx, Poland

    \  /       Partly Cloudy
  _ /"".-.     8 – 10 °C
    \_(   ).   ↓ 11 km/h
    /(___(__)  10 km
               0.0 mm
 ```
or

 ```
 $ weather warsaw
 Weather for City: Warsaw, Poland

      .-.      Light Rain
     (   ).    9 – 10 °C
    (___(__)   ↓ 9 km/h
     ‘ ‘ ‘ ‘   10 km
    ‘ ‘ ‘ ‘    0.0 mm
 ```

 - whatismydns - get current dns server ip

 ```
 $ whatismydns
 8.8.8.8
 ```

 - whatismyip - get gloal IP address

 ```
 $ whatismyip
 83.233.158.162
 ```

 - whatismyip-local - get IP address in internal network

 ```
 $ whatismyip-local
 10.20.26.23
 ```
 - whatportis - get port/service-name details by port/service name-name

 ```
 $ whatportis redis
 Service Name  Port Number  Transport Protocol  Description
 redis         6379         tcp                 An advanced key-value cache and store
 ```

 - whatportis-update - update whatportis database

 - wifi-signal - monitor wifi signal strength

## osx

 - battery - get battery level for keyboard and mouse
 - finder-open-icons - open folder with macos icons
 - flush-dns - flush dns
 - github-open - open remote url in github
 - github-pr-open - open create-pr page with current branch
 - napi - alias for napi - subtitle search
 - sublime - alias for SublimeText
 - stree - alias for SourceTree
 - tor-proxy - enable/disable tor socks proxy for localhost:9050
 - travis-open - open remote url related task in travis
 - vscode - open given directory in VSCode
 
 ## rpi
 
  - display-power - switch on/off screen
 
## security
 
  - clean-cache - remove cache of given type from disk
  - clean-defaults - clean history stored in defaults values
  - clean-exif - clean exif metadata from given image
  - disable-history - disable bash history for current session
  - find-suid - find all files with suid mode set
  - randomize-mac - set random mac address to given interface

  ```
  $ randomize-mac en1
  New hw address for en1 is 0d2dfe8ed543
  ```

## server
  - mongod - start mondog server using db ~/.mongod 
  - server-static-python2 - simple static http server in python2
  
  ```
  $ server-static-python2 [port]
  ```
  
  - server-static-python3 - simple static http server in python3
  - server-static-php - simple static http server in php
  - server-static-ruby - simple static http server in ruby
 
## util

 - .. - cd ..
 - cd-dotfiles - cd to dotfiles path
 - cd-nmap-scripts-user - cd to user's nmap scripts
 - cd-nmap-scripts-global - cd to global nmap scripts path
 - cd-workspace - cd to path ~/Workspace
 - cd-workspace-nodejs - cd to path ~/Workspace/nodejs
 - cd-workspace-ops - cd to path ~/Workspace/ops
 - cd-workspace-svp - cd to path ~/Workspace/svp
 - grep - colorized grep
 - ll - alias to ls -al
 - m4a2mp3 - convert all m4a file to mp3 in current directory
 - napi-find - search for subtitles fo video movies recursively
 - count-uniq - count unique lines from piped input
 - yt2mp3 - download youtube video and convert to mp3
