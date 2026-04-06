#!/usr/bin/env zsh
# =========================================================
# Solvalutions - Shell Aliases & Configuration
# Optimized for Senior B2B Tech Partner Workflow
# =========================================================

# --- 1. Core & Navigation ---
alias vi="nvim"
alias v="nvim"
alias g="lazygit"
alias nvimrc="cd ~/.config/nvim && nvim"
alias md="mkdir -p"
alias rd="rmdir"

# --- 2. Security & Confirmation (Safety First) ---
# Prevents accidental overwrites and deletions
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# --- 3. Modern Tooling (eza & bat) ---
# High-performance metadata display using Rust-based tools
if command -v eza &> /dev/null; then
    alias ls="eza --icons --group-directories-first"
    alias la="eza -la --icons --group-directories-first"
    alias ll="eza -l --icons --group-directories-first"
    alias lt="eza -la --sort=modified --icons"           # Sort by date (newest first)
    alias lr="eza -la --sort=modified --reverse --icons" # Sort by date (oldest first)
    alias ldot="eza -ld .* --icons"                      # Show only dotfiles
    alias tree="eza -laT --icons"                        # Recursive tree view
else
    alias ls="ls --color=auto"
    alias la="ls -lAFh"
fi

if command -v bat &> /dev/null; then
    alias cat="bat -pp --theme 'Dracula'"
    alias catt="bat --theme 'Dracula'"
fi

# --- 4. Docker Operations ---
alias dexec="docker exec -it"
alias drun="docker compose run --rm"
alias dup="docker compose up -d"
alias dhalt="docker compose down"
alias dreload="docker compose down && docker compose up -d"
alias dssh="docker compose exec php bash"
# Maintenance: Remove all unused resources
alias drmall="docker ps -aq | xargs -r docker rm -f"
# Lookup: Get container IP address
alias dgetip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

# --- 5. System & Performance Monitoring ---
alias df="df -h"
alias free="free -m"
alias psmem="ps auxf | sort -nr -k 4 | head -5"
alias pscpu="ps auxf | sort -nr -k 3 | head -5"
alias grep='grep --color=auto'
alias ff='find . -type f -name'

# --- 6. Navigation Logic & Directory Stack ---
# Enables O(1) jumping between recently visited directories
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'

# --- 7. Infrastructure & Utilities ---
# Secure O(1) external IP lookup
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

# Ansible Vault management
alias av='ansible-vault'
alias avv='ansible-vault view'
