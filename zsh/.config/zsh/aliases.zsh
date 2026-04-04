#!/usr/bin/env zsh
# =========================================================
# Aliases - Rob Meijerink
# Security-first workflow with modern tool integration
# =========================================================

# --- 1. Core & Navigation ---
alias vi="nvim"
alias v="nvim"
alias g="lazygit"
alias nvimrc="cd ~/.config/nvim && nvim"
alias md="mkdir -p"
alias rd="rmdir"

# --- 2. Security & Confirmation (Broeder Beer Safety) ---
# Atomic-level safety: prevents accidental overwrites and deletions
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# --- 3. Modern Tooling (eza & bat) ---
# Use modern Rust-based tools for O(1) metadata display performance
if command -v eza &> /dev/null; then
    alias ls="eza --icons --group-directories-first"
    alias la="ls -la"
    alias ll="ls -l"
    alias lst="ls -T"
    alias tree="ls -laT"
else
    alias ls="ls --color=auto"
    alias la="ls -lAFh"
fi

if command -v bat &> /dev/null; then
    alias cat="bat -pp"
    alias catt="bat"
fi

# --- 4. Docker ---
alias dexec="docker exec -it"
alias drun="docker compose run --rm"
alias dup="docker compose up -d"
alias dhalt="docker compose down"
alias dreload="docker compose down && docker compose up -d"
alias dssh="docker compose exec php bash"
# Performance: Cleanup unused resources to maintain O(1) system responsiveness
alias drmall="docker ps -aq | xargs -r docker rm -f"
alias dgetip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

# --- 5. System & Performance Monitoring ---
alias df="df -h"
alias free="free -m"
alias psmem="ps auxf | sort -nr -k 4 | head -5"
alias pscpu="ps auxf | sort -nr -k 3 | head -5"

# --- 6. Navigation Logic (Global Aliases) ---
setopt auto_cd
setopt auto_pushd
alias -g ...='../..'
alias -g ....='../../..'
alias -- -='cd -'

# --- 7. Utility ---
# Check external IP (Reliable O(1) external lookup)
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

# --- 8. OS Specific & FZF Bindings ---
case "$(uname -s)" in
    Darwin)
        # MacOS specific logic here
        ;;
    Linux)
        # Ensure FZF completion/bindings are loaded if they exist
        # This assumes standard Linuxbrew/FZF paths
        [[ -f "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.zsh" ]] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.zsh"
        [[ -f "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh" ]] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh"
        ;;
esac