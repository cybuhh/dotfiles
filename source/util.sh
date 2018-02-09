#!/usr/bin/env bash

alias ..="cd .."

alias cd-dotfiles='cd $DOTFILES_PATH'
alias cd-nmap-scripts-global='cd /usr/local/share/nmap/scripts'
alias cd-nmap-scripts-user='cd ~/.nmap/scripts'
alias cd-workspace='cd ~/Workspace'
alias cd-workspace-nodejs='cd ~/Workspace/nodejs'
alias cd-workspace-ops='cd ~/Workspace/ops'
alias cd-workspace-svp='cd ~/Workspace/svp'

alias grep='grep --color=auto'

alias ll='ls -al'
alias napi-find='find . -name "*.avi" -o -name "*.mpg" -o -name "*.mpeg" -o -name "*.mp4" -o -name "*.qt" -o -name "*.mkv" -o -name "*.m2v" | while read file; do test -f "${file%.*}.txt" || (qnapi "$file" | grep "Dopasowywanie" > /dev/null && echo "Downloaded subtitles for $file"); done'
alias m4a2mp3='for i in *.m4a; do ffmpeg -i "$i" "${i}".mp3; done'

# params: [limit=100]
# eg.: cat dump.txt | count-uniq 10
function count-uniq {
  sort | uniq -c | sort -r | head -n ${1:-100}
}
