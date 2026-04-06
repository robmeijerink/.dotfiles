#!/usr/bin/env zsh
# =========================================================
# Exports - Rob Meijerink
# Bulletproof PATH Reconstruction for macOS & Linux
# =========================================================

# --- 1. Identity & Security ---
if [[ -x /usr/bin/tty ]]; then
    export GPG_TTY=$(/usr/bin/tty)
else
    export GPG_TTY=$TTY
fi

# --- 2. Homebrew / Linuxbrew Initialization ---
if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# --- 3. Bulletproof Path Reconstruction ---
# We force the path array to a specific order to override any plugin interference
typeset -U path

path=(
    "$HOME/.local/bin"
    "$HOME/.local/scripts"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "/usr/local/go/bin"
    "/usr/local/bin"
    "/usr/local/sbin"
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
)

# OS Specific Path Additions
SYSTEM_TYPE=$(/usr/bin/uname -s)
case "$SYSTEM_TYPE" in
    Darwin)
        path=("$HOME/.composer/vendor/bin" $path)
        ;;
    Linux)
        path=("$HOME/.config/composer/vendor/bin" $path)
        ;;
esac

# Explicitly export to the global environment
export PATH

# --- 4. History Configuration ---
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt appendhistory
setopt sharehistory
setopt histignorealldups

# --- 5. Default Applications ---
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"

# --- 6. Tool Initializations ---
# Zoxide: Fast directory jumping
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# FNM: Fast Node Manager
if command -v fnm &> /dev/null; then
    eval "$(fnm env --use-on-cd)"
fi

# --- 7. Pager & Documentation ---
export MANPAGER='nvim +Man!'
export MANWIDTH=999