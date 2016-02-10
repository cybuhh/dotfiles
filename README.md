# dotfiles

## apps
 - sublimetext - open file in SublimeText
 - textedit - open file in TextEdit

## common

 - dotfiles-commit - commit to dotfiles repo
 - dotfiles-push - push to dotfiles repo

## dev

 - foreman-supervisor - alias for 'foreman run supervisor'
 - mongo-url - connect to mongo from mongourl in format mongodb://user:pass@host:port/db_name

## git

 - git-commits-waiting - commits waiting to be pushed
 - git-master - git fetch & checkout master & pull
 - git-rebase - git fetch & rebase to origin/master
 - git-rebuid - git rebuild (empty commit)
 - git-submodule-update - git fetch and refresh all submodules

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
- packtpub-free - show free packtpub's book for today
 ```
 $ packtpub-free
 PhoneGap and AngularJS for Cross-platform Development
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

## utils

 - ll - alias to ls -al
 - profile-reoload - reload .profile file
 
