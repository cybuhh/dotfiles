# dotfiles

Add to your .profile or .bash_profile line below to load it

```source [DOTFILES_PATH]/init.sh```

## apps
 - sublimetext - open file in SublimeText
 - textedit - open file in TextEdit

## common

 - backup - copy file/folder with current date suffix

## dev

 - docker-cleanup - alias for all docker prune commands
 - foreman-supervisor - alias for 'foreman run supervisor'
 - mongo-url - connect to mongo from mongo url in format mongodb://user:pass@host:port/db_name
 - nvm-update - update current used nodejs to newest version, alias to default,
   reinstall packages from current version and remove old nodejs version
 - redis-cli-url - connect to redis from redis url in format redis://user:pass@host:port
 - server - simple netcat server, listen on given port, dump request and respond with given status code
   e.g. server 8000 200

## dotfiles

 - dotfiles-commit - commit to dotfiles repo
 - dotfiles-push - push to dotfiles repo
 - dotfiles-reoload - reload dotfile scripts
 - dotfiles-update - update dotfiles repo
 - dotfiles-install - install vendors etc.

## git

 - git-commits-waiting - commits waiting to be pushed
 - git-master - git fetch & checkout master & pull
 - git-rebase - git fetch & rebase to origin/master
 - git-rebuid - git rebuild (empty commit)
 - git-submodule-update - git fetch and refresh all submodules
 - git-is-file-changed - check if given file was modified

## heroku

 - heroku-deploy-dev - deploy to dev
 - heroku-deploy-stage - deploy to stage
 - heroku-deploy-promote - promote stage to production

## net

 - curl-size-raw - get size of raw source
 
 ```
 $ curl-size-raw google.com
 258
 ```

 - curl-size-gzip - get size of gzip-ed source
 
 ```
 $ curl-size-gzip google.com`
 258
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

## osx

 - battery - get battery level for keyboard and mouse
 - napi - alias for napi - subtitle search
 - sublime - alias for SublimeText
 - stree - alias for SourceTree
 - tor-prooxy - enable/disable tor socks proxy for localhost:9050
 
## security
 
  - cache-clean - remove cache of given type from disk
  - defaults-clean - clean history stored in defaults values
 
## utils

 - ll - alias to ls -al
 - napi-find - search for subtitles fo video movies recursively

## work

 - kali-ip - get ip of kali host
 - log-yata-[stage/prod] - tail yata logs
 - log-sifter-indexer-[stage/prod] -  tail sifter indexer logs
 - log-sifter-api-[stage/prod] - tail sifter api logs

