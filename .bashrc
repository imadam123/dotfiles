#!/bin/bash
# My bashrc.



[[ $- != *i* ]] && return
colors() { local fgc bgc vals seq-
	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a \e[1mbold-faced look\e[m\n\n"
	#foreground colors
	for fgc in {30..37}; do
		#background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black
			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}
			seq0="$vals:+\e[${vals}m}"
			printf "  %-92" "${seq0:-(default)}"
			printf " ${seq-}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done; echo; echo; done }

##Auto complete stuff
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Minimise the risk of pastejacking
# See: https://lists.gnu.org/archive/html/bug-bash/2019-02/msg00057.html
set enable-bracketed-paste On

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# fix a retarded error in some things
export LC_ALL=en_US.UTF-8

export LANG=en_US.UTF-8


# Provide a function to compress common compressed Filetypes
compress() {
  File=$1
  shift
  case "${File}" in
    (*.tar.bz2) tar cjf "${File}" "$@"  ;;
    (*.tar.gz)  tar czf "${File}" "$@"  ;;
    (*.tgz)     tar czf "${File}" "$@"  ;;
    (*.zip)     zip "${File}" "$@"      ;;
    (*.rar)     rar "${File}" "$@"      ;;
    (*)         echo "Filetype not recognized" ;;
  esac
}

# calculate how many seconds since epoch
epoch() {
  local y j h m s yo

# Extracting
extract () {

 if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"

 fi
}

  alias reloadbash='source $HOME/.bashrc'
}
