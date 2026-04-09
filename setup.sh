#!/usr/bin/env bash
# =========================================================
# Setup/Bootstrap - Rob Meijerink
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

# 3. Folders exclusive to macOS
MAC_FOLDERS=(
    "aerospace"
)

# Initialize final list with common folders
STOW_FOLDERS=("${COMMON_FOLDERS[@]}")

# 4. OS Detection Logic
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "OS: Linux detected. Adding Wayland-specific folders..."
    STOW_FOLDERS+=("${LINUX_FOLDERS[@]}")
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "OS: macOS detected. Adding macOS-specific folders..."
    STOW_FOLDERS+=("${MAC_FOLDERS[@]}")
fi

# Navigate to the repo root
cd "$(dirname "$0")"

# 5. Synchronization Process
for folder in "${STOW_FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        # Check for existing real files and backup (O(1) safety check per file)
        find "$folder" -maxdepth 1 -not -path "$folder" | while read -r src; do
            filename=$(basename "$src")
            target="$HOME/$filename"

            if [ -e "$target" ] && [ ! -L "$target" ]; then
                mv "$target" "$target.bak"
                echo "Backup created: $target.bak"
            fi
        done

        stow -t ~ --restow "$folder"
        echo "Successfully stowed: $folder"
    else
        echo "Warning: Folder $folder not found, skipping..."
    fi
done

echo "OK: Dotfiles synchronized for $OSTYPE."
