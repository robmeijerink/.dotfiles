#!/bin/zsh
# =========================================================
# Aliases - Rob Meijerink
# Security-first workflow with modern tool integration
# =========================================================

# --- 1. Core & Navigation ---
alias vi="nvim"
alias g="lazygit"
alias nvimrc="nvim ~/.config/nvim/"
alias md="mkdir -p"
alias rd="rmdir"

# --- 2. Security & Confirmation (Broeder Beer Safety) ---
# Prevents accidental overwrites and deletions
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# --- 3. Modern Tooling (eza & bat) ---
# O(1) alias lookups in Zsh hash table
if command -v eza &> /dev/null; then
  alias ls="eza --icons --group-directories-first"
  alias la="ls -la"
  alias ll="ls -l"
  # Tree-view aliases (eza specific)
  alias lst="ls -T"
  alias llt="ls -lT"
  alias lat="ls -laT"
  alias tree="ls -laT"
else
  # Fallback for vanilla ls
  alias ls="ls --color=auto"
  alias la="ls -lAFh"
fi

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme 'Dracula'"
  alias catt="bat --theme 'Dracula'"
fi

# --- 4. Docker (Solvalutions Standard) ---
alias dexec="docker exec -it"
alias drun="docker compose run --rm"
alias dup="docker compose up -d"
alias dhalt="docker compose down"
alias dreload="docker compose down && docker compose up -d"
alias dssh="docker compose exec php bash"
# Safe removal: prevents error if no containers exist
alias drmall="docker ps -aq | xargs -r docker rm -f"
alias dgetip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

# --- 5. System & Performance ---
alias df="df -h"
alias free="free -m"
alias psmem="ps auxf | sort -nr -k 4 | head -5"
alias pscpu="ps auxf | sort -nr -k 3 | head -5"

# --- 6. Navigation Logic ---
setopt auto_cd
setopt auto_pushd
alias -g ...='../..'
alias -g ....='../../..'
alias -- -='cd -'

# --- 7. Utility ---
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias pwgen="openssl rand -base64 256 | tr -dc '[:print:]' | head -c 32"

# --- 8. OS Specific ---
case "$(uname -s)" in
  Darwin)
    # macOS specific logic
    ;;
  Linux)
    # Linux specific logic (FZF bindings)
    current_dir=$(dirname "$0")
    [[ -f "$current_dir/fzf/completion.zsh" ]] && source "$current_dir/fzf/completion.zsh"
    [[ -f "$current_dir/fzf/key-bindings.zsh" ]] && source "$current_dir/fzf/key-bindings.zsh"
    ;;
esac