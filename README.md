# dotfiles

Add to your .profile or .bash_profile line below to load it

```source [DOTFILES_PATH]/init.sh```

## apps
 - sublimetext - open file in SublimeText
 - textedit - open file in TextEdit
 - chrome-dws - run chrome with disabled web security
 - codium - run vscodium with --enable-proposed-api flag for pull-request-github

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
 - git-add-selective - alias to git add -p
 - git-branch-rename - rename current local and remote branch
 - git-c - git commit alias
 - git-commits-waiting - commits waiting to be pushed
 - git-commit-again - commit again to previous and force push
 - git-is-file-changed - check if given file was modified
 - git-log-oneline - git log in 'oneline' format
 - git-master - git fetch & checkout master & pull
 - git-push-force-with-lease - git push with flag --force-with-lease
 - git-rebase - git fetch & rebase to origin/master
 - git-rebuid - git rebuild (empty commit)
 - git-reset - git reset hard to HEAD
 - git-scan-changes - scan all subfolders for git repo and check for unstaged files, uncommited changes, and not pushed commits
 - git-set-details - set given username and email for current repo
 - git-set-details-github - github alias username and email for current repo 
 - git-submodule-update - git fetch and refresh all submodules

## net

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

- ping-port - ping tcp port on host
 
 ```
 $ ping-port google.com 443
 close
 ```

 

  ```
  $ scan-for-rpi 192.168.20.0/24
  192.168.20.30
  ```

 - route-lan - add local routes for lan

 - show-rpi-from-arp - show raspberry pi hosts in arp entries

 ```
 $ show-rpi-from-arp
 ? (192.168.20.30) at b8:27:eb:7d:a6:f7 on en0 ifscope [ethernet]
 ```

 - ssh-noconfig - ssh without loading config file
 
 - ssh-pass - ssh with forced password auth
 
 - ssl-check - show ssl certificate details for given domain name

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

 - weather-v2 - alternative weather presentation

```
 $ weather-v2
┌┤  weather report for: krakow,pl  ├─────────────────────────────────────┐
│                                                                        │
│                                                                        │
│       Wed 28 Aug              Thu 29 Aug              Fri 30 Aug       │
│                       ╷                       ╷                        │
│                                                                        │
│                                                                        │
│+31         ⡠⠔⠉⠉⠉⠢⢄⡀               ⡠⠊⠉⠑⠢⣀⡀                   ⢀⠔⠉⠉⠉⠢⡀    │
│          ⡠⠊       ⠈⠑⡄            ⡰⠁     ⠈⢆                 ⣠⠃     ⠑⡄   │
│         ⡰⠁          ⠱⡀          ⢠⠃        ⢇               ⡰⠁       ⠈⢆  │
│        ⢠⠃            ⢇          ⡏         ⠘⡄             ⢠⠃          ⠣⡀│
│        ⠎             ⠘⡄        ⢸           ⢣             ⡎             │
│       ⢠⠃              ⢣        ⡇           ⠈⡆           ⡸              │
│       ⡎               ⠘⡄      ⡸             ⢱          ⢠⠃              │
│      ⢰⠁                ⢱     ⢀⠇              ⢆         ⡎               │
│⣆    ⢀⠇                  ⠣⡀  ⢀⠎               ⠈⠢⡀      ⠜                │
│+17⣀⢀⠎                    ⠈⠉⠉⠁                  ⠈⠑⠢⢄⣀⣀⠎⠁                │
│                                                                        │
│─────┴─────┼─────┴─────╂─────┴─────┼─────┴─────╂─────┴─────┼─────┴─────╂│
│     6    12    18           6    12    18           6    12    18      │
│                                                                        │
│                  3.09mm|72%                                            │
│                    ▃▅██▇▁                     ▁▇█▃                     │
│                   ███████▂                  ▁▅████▃                    │
│                  █████████▁               ▁▇███████▂                   │
│                 ▅██████████▁             ▃██████████▄                 ▃│
│                ▃████████████▄_          ▅██████████████▅▄▂▁_     _▁▃▅██│
│                                                                        │
│                                                                        │
│🌦  ⛅️ ⛅️ ⛅️ ⛅️ ⛅️ ⛈  🌧  🌧  🌧  ⛅️ ⛅️ ⛅️ ⛅️ 🌦  🌦  🌦  🌧  🌦  🌦  ⛅️ ⛅️ ⛅️ 🌦  │
│ ↑  ↑  ↖  ↖  ↖  ↖  ←  ↖  ↑  ↖  ↖  ↑  →  ↗  ↑  ↑  ↗  →  →  ↘  ↑  ←  ↖  ↖ │
│ 4  4  4  7  9  10 15 12 6  5  4  4  6  13 16 10 6  4  3  2  5  8  6  4 │
│                                                                        │
│🌘                      🌘                      🌑                   🌑 │
│     ─━━━━━━━━━━━━━─         ─━━━━━━━━━━━━━─         ─━━━━━━━━━━━━━─    │
│                                                                        │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
Weather: ☀️ Sunny, +17°C, 94%, ↙6 km/h, 1021hPa
Timezone: Europe/Warsaw
  Now:    07:37:32+0200 | Dawn:    05:14:00  | Sunrise: 05:48:16
  Noon:   12:41:43      | Sunset:  19:35:11  | Dusk:    20:09:26
Location: Kraków, małopolskie, Polska [50.0615,19.9359]
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

## macos

 - battery - get battery level for keyboard and mouse
 - open-icons - cd macos system icons folder in finder
 - cleanup-cache - remove cache of given type from disk
 - cleanup-vlc-recent - clean VLC recent history
 - cdr2iso - convert .cdr to .iso
 - fcp-reset-trial - reset final cut pro x trial
 - fix-bt - fix bluetooth issues
 - finder-open-icons - open folder with macos icons
 - fix-spotlight - reset spotlight indices
 - flush-dns - flush dns
 - gh-open - open remote url in github
 - gh-pr-open - open create-pr page with current branch
 - ls-autostart - list autostart items in all locations
 - napi-find - alias for napi - subtitle search
 - restart-icloud - restart hanging iCloud sercice
 - sync-jumpdesktop - sync JumpDesktop settings to sync bucket
 - sync-forklift - sync JumpDesktop settings to sync bucket
 - sublime - alias for SublimeText
 - stree - alias for SourceTree
 - tor-proxy - enable/disable tor socks proxy for localhost:9050
 - travis-open - open remote url related task in travis
 
## rpi
 
  - display-power - switch on/off screen
  - temp - show cpu temperature
 
## security
 
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
 - count-uniq - count unique lines from piped input
 - fix-xcode-cli - fix xcode command line tools
 - grep - colorized grep
 - hostname-set - set HostName/LocalHostName/ComputerName to prefered one and flush dns
 - ll - alias to ls -al
 - m4a2mp3 - convert all m4a file to mp3 in current directory
 - md-status - show md raid status
 - napi-find - search for subtitles fo video movies recursively - whatthecommit - get whatthecommit.com message
 - yt2mp3 - download youtube video and convert to mp3
 - yt2mp3-dlp - download youtube video and convert to mp3 (yt-dlp)
