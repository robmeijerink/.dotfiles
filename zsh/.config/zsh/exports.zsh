#!/usr/bin/env zsh
# =========================================================
# Exports - Rob Meijerink
# =========================================================

# --- 1. Emergency Path Setup ---
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# --- 2. Identity & Security ---
if [[ -x /usr/bin/tty ]]; then
    export GPG_TTY=$(/usr/bin/tty)
else
    export GPG_TTY=$TTY
fi

# --- 3. Homebrew / Linuxbrew Initialization ---
if [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# --- 4. Path Management ---
typeset -U path

path=(
    "$HOME/.local/bin"
    "$HOME/.local/scripts"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "/usr/local/go/bin"
    $path
)

# OS Specific Path Logic
CURRENT_OS=$(/usr/bin/uname -s)

case "$CURRENT_OS" in
    Darwin)
        path=("$HOME/.composer/vendor/bin" $path)
        ;;
    Linux)
        path=("$HOME/.config/composer/vendor/bin" $path)
        ;;
esac

export PATH

# --- 5. History & Apps ---
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"

# --- 6. Tool Initializations ---
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

if command -v fnm &> /dev/null; then
    eval "$(fnm env --use-on-cd)"
fi