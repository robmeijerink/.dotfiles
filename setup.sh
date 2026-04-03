#!/usr/bin/env bash

# ---------------------------------------------------------
# 1. Prepare Required Directories
# ---------------------------------------------------------
# Ensure Neovim/Vim swap and backup directories exist
mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/backup
mkdir -p ~/.vim/tmp/swap

# ---------------------------------------------------------
# 2. Stow Configurations
# ---------------------------------------------------------
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

# Navigate to the directory where this script is located
cd "$(dirname "$0")" || exit 1

for f in "${STOW_FOLDERS[@]}"; do
    echo "Stowing: ${f}..."
    # --restow ensures idempotency (updates existing links without failing)
    stow --restow "${f}"
done

echo "Configuration applied successfully."
