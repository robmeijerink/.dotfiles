#!/bin/zsh
# =========================================================
# Exports - Rob Meijerink
# Optimized for $O(1)$ path lookups and cross-platform
# =========================================================

# --- 1. Identity & Security (Broeder Beer Reliability) ---
# Essential for GPG-signed commits in Neovim/Tmux
export GPG_TTY=$(tty)

# --- 2. History Configuration ---
# XDG compliance: Keep the home directory clean
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000

# --- 3. Default Applications ---
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"

# --- 4. Path Management (The Senior Way) ---
# typeset -U path: Ensures the PATH array only contains unique entries
typeset -U path

# Define base paths
path=(
    "$HOME/.local/bin"
    "$HOME/.local/scripts"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "/usr/local/go/bin"
    $path
)

# OS Specific Path Additions
case "$(uname -s)" in
    Darwin)
        # MacOS Composer path
        path=("$HOME/.composer/vendor/bin" $path)
        ;;
    Linux)
        # Linux Composer path
        path=("$HOME/.config/composer/vendor/bin" $path)
        ;;
esac

# Export the final path
export PATH

# --- 5. Language Specifics ---
export GOPATH="$HOME/go"

# --- 6. Pager & Documentation ---
# Use Neovim as manpager for better navigation and syntax highlighting
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# --- 7. Tool Initializations ---
# Zoxide: Fast directory jumping (Fzf-powered)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi