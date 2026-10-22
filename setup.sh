#!/usr/bin/env bash
# =========================================================
# Setup/Bootstrap - Rob Meijerink
# =========================================================

set -e

# 1. Folders shared by both macOS and Fedora
COMMON_FOLDERS=(
    "alacritty"
    "bin"
    "claude"
    "git"
    "lazygit"
    "nvim"
    "php"
    "tmux"
    "vim"
    "zsh"
)

# 2. Folders exclusive to the Fedora Wayland setup
LINUX_FOLDERS=(
    "mako"
    "sway"
    "waybar"
    "wofi"
)

# 3. Folders exclusive to macOS
MAC_FOLDERS=(
    "aerospace"
    "karabiner"
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
        # Back up real files that would block a link. Checked per file, not per
        # top-level folder, so shared folders like ~/.config are never moved;
        # -ef skips files already reached through a stowed (folded) link.
        find "$folder" -type f | while read -r src; do
            target="$HOME/${src#"$folder"/}"

            if [ -e "$target" ] && [ ! -L "$target" ] && [ ! "$target" -ef "$src" ]; then
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

# 6. rust-analyzer for Claude Code's LSP plugin (Neovim uses Mason's copy)
if command -v rustup >/dev/null; then
    rustup component add rust-analyzer
fi

echo "OK: Dotfiles synchronized for $OSTYPE."
