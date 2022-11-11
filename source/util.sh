#!/usr/bin/env bash

alias ..="cd .."

alias cd-dotfiles='cd $DOTFILES_PATH'
alias cd-nmap-scripts-global='cd /usr/local/share/nmap/scripts'
alias cd-nmap-scripts-user='cd ~/.nmap/scripts'
alias cd-workspace='cd ~/Workspace'
alias cd-workspace-nodejs='cd ~/Workspace/nodejs'

alias excuse="bash $DOTFILES_VENDOR_PATH/excuse/bin/excuse.sh"
alias grep='grep --color=auto'
alias heic2jpg='for i in `ls -1 | grep -i ''.heic'' | tr ''.HEIC'' ''.heic''`; do magick "$i" "${i/.heic/.jpg}"; done'
alias ll='ls -al'
alias m4a2mp3='for i in *.m4a; do ffmpeg -i "$i" "${i}".mp3; done'
alias napi-find='find . -name "*.avi" -o -name "*.mpg" -o -name "*.mpeg" -o -name "*.mp4" -o -name "*.qt" -o -name "*.mkv" -o -name "*.m2v" | while read file; do test -f "${file%.*}.srt" || (qnapi -q "$file" | grep "Dopasowywanie" > /dev/null && echo "Downloaded subtitles for $file"); done'
alias yt2mp3='youtube-dl -x --audio-format mp3 -f bestaudio'
alias whatthecommit="curl -sS http://whatthecommit.com/index.txt"

# params: [limit=100]
# eg.: cat dump.txt | count-uniq 10
function count-uniq {
  sort | uniq -c | sort -r | head -n "${1:-100}"
}

function fix-xcode-cli() {
  xcode-select — install
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
  sudo xcodebuild -license accept
}

function file-lowercase {
	find . -name "$1" -print0 |
    while IFS= read -r -d $'\0' oldName; do
		echo "$oldName"
		#newName=$(echo "$oldName" | tr '[:upper:]' '[:lower:]')
		#mv "$oldName" "$newName"
	done
}
