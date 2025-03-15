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
alias video2mp4='for i in *.{avi,m4v,wmv,webm}; do test -f "$i" && ffmpeg -i "$i" "$(basename "${i%.*}").mp4"; done'
alias m4a2mp3='for i in *.m4a; do ffmpeg -i "$i" "${i}".mp3; done'
alias napi-find='find . -name "*.avi" -o -name "*.mpg" -o -name "*.mpeg" -o -name "*.mp4" -o -name "*.qt" -o -name "*.mkv" -o -name "*.m2v" | while read file; do test -f "${file%.*}.srt" || (qnapi -q "$file" | grep "Dopasowywanie" > /dev/null && echo "Downloaded subtitles for $file"); done'
alias yt2mp3='youtube-dl -x --audio-format mp3 -f bestaudio'
alias yt2mp3-dlp='yt-dlp -x --audio-format mp3 -f bestaudio'
alias yt2mp4='youtube-dl -f bestvideo+bestaudio --merge-output-format mp4'
alias yt2mp4-dlp='yt-dlp -f bestvideo+bestaudio --merge-output-format mp4'
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

function hostname-set {
  sudo scutil --set HostName $1
  sudo scutil --set LocalHostName $1
  sudo scutil --set ComputerName $1
  sudo hostname -s $1
  dscacheutil -flushcache
}

lanscan-backup="cp -f $HOME/Library/Group\ Containers/AATLWWB4MZ.com.iwaxx.app-group/Library/Application\ Support/DevicesDict-LS.plist $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/apps.sync/LanScan"
lanscan-restore="cp -f $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/apps.sync/LanScan $HOME/Library/Group\ Containers/AATLWWB4MZ.com.iwaxx.app-group/Library/Application\ Support/DevicesDict-LS.plist"
