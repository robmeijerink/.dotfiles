#!/usr/bin/env bash
# =========================================================
# Setup/Bootstrap - Rob Meijerink (Solvalutions)
# Optimized for Headless Ansible Execution
# =========================================================

set -e

# 1. Ensure directories exist (O(1) complexity)
mkdir -p ~/.vim/tmp/{undo,backup,swap}

# 2. Configurable folder list
STOW_FOLDERS=(
    "alacritty"
    "bin"
    "git"
    "lazygit"
    "nvim"
    "php"
    "tmux"
    "vim"
    "zsh"
)

# Navigate to the repo root (where this script lives)
cd "$(dirname "$0")"

for folder in "${STOW_FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        # Nuchtere fix voor bestaande bestanden:
        # We zoeken naar conflicten en ruimen ze op VOORDAT we stowen.
        # Dit voorkomt de beruchte 'stow error: existing target'
        find "$folder" -maxdepth 1 -not -path "$folder" | while read -r src; do
            filename=$(basename "$src")
            target="$HOME/$filename"

            # Als het een echte file is en GEEN link, hernoem hem (idempotentie)
            if [ -e "$target" ] && [ ! -L "$target" ]; then
                mv "$target" "$target.bak"
            fi
        done

        # --restow: forceert de update van de link, ook als deze al bestaat.
        # -t ~: Expliciete target voor Home directory
        stow -t ~ --restow "$folder"
    fi
done

echo "OK: Dotfiles synchronized via Stow."