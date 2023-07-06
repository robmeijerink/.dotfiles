#!/bin/sh
alias vi="nvim"
alias g='lazygit'
alias nvimrc='nvim ~/.config/nvim/'

# Devilbox
alias dup="cd ~/devilbox && docker-compose up -d && cd -"
alias dhalt="cd ~/devilbox && docker-compose down && cd -"
alias dreload="cd ~/devilbox && docker-compose down && docker-compose up -d && cd -"
alias dssh="cd ~/devilbox/ && ./shell.sh"

# Docker compose
alias dexec="docker exec -it"
alias drun="docker-compose run --rm"

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Dracula\""
  alias catt="bat --theme \"Dracula\""
fi

# ls, the common ones I use exa for ls
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lt='ls -la --sort=modified'   #sorted by date,recursive,show type,human readable
alias lr='ls -la --sort=modified --reverse'   #sorted by date,recursive,show type,human readable
alias ldot='ls -ld .*'
alias lst='ls -T'     #ls with tree
alias llt='ls -lT'    #ls -l with tree
alias lat='ls -laT'   #ls -la with tree
alias latr='ls -laT --sort=modified --reverse'   #ls -la with tree

# Tree overwrite
alias tree='ls -laT'   #ls -la with tree

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# find & grep
alias ff='find . -type f -name'

# ansible
alias av='ansible-vault'
alias avv='ansible-vault view'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# Changing/making/removing directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir

# Helper utilities
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
# Random password with any character
alias pwgen="openssl rand -base64 256 | tr -dc '[:print:]' | head -c 32"
# Random password with only alphanumeric characters
alias pwgena="openssl rand -base64 256 | tr -d '\n' | head -c 32"

# Gets the directory of this file.
current_dir=$(dirname "$0")

case "$(uname -s)" in

Darwin)
	# echo 'Mac OS X'
	alias ls='ls -G'
	;;

Linux)
	alias ls='ls --color=auto'
    source "$current_dir/fzf/completion.zsh"
    source "$current_dir/fzf/key-bindings.zsh"
	;;
CYGWIN* | MINGW32* | MSYS* | MINGW*)
	# echo 'MS Windows'
	;;
*)
	# echo 'Other OS'
	;;
esac
