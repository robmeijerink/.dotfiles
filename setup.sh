#!/usr/bin/env bash
# =========================================================
# Setup/Bootstrap - Rob Meijerink
# OS-Aware Dotfile Synchronization
# =========================================================

set -e

# 1. Folders shared by both macOS and Ubuntu
COMMON_FOLDERS=(
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

# 2. Folders exclusive to the Ubuntu Wayland setup
LINUX_FOLDERS=(
    "mako"
    "sway"
    "waybar"
    "wofi"
)

# Initialize final list with common folders
STOW_FOLDERS=("${COMMON_FOLDERS[@]}")

# 3. OS Detection Logic
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "OS: Linux detected. Adding Wayland-specific folders..."
    STOW_FOLDERS+=("${LINUX_FOLDERS[@]}")
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "OS: macOS detected. Skipping Wayland-specific folders."
fi

# Navigate to the repo root
cd "$(dirname "$0")"

# 4. Synchronization Process
for folder in "${STOW_FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        # Check for existing real files and backup
        find "$folder" -maxdepth 1 -not -path "$folder" | while read -r src; do
            filename=$(basename "$src")
            target="$HOME/$filename"

            if [ -e "$target" ] && [ ! -L "$target" ]; then
                mv "$target" "$target.bak"
            fi
        done

        stow -t ~ --restow "$folder"
        echo "Successfully stowed: $folder"
    else
        echo "Warning: Folder $folder not found, skipping..."
    fi
done

echo "OK: Dotfiles synchronized for $OSTYPE."
