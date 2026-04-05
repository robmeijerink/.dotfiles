#!/usr/bin/env bash
set -e

# Detect Operating System
OS="$(uname -s)"
echo "--- Starting full maintenance for $OS ---"

# Keep-alive sudo: update the timestamp and keep it fresh
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [ "$OS" = "Linux" ]; then
    echo "Updating System Packages (APT & Snap)..."
    sudo apt update && sudo apt upgrade -y
    sudo snap refresh
    sudo apt autoremove -y && sudo apt clean

elif [ "$OS" = "Darwin" ]; then
    echo "Updating macOS App Store apps..."
    if command -v mas >/dev/null; then mas upgrade; fi
fi

# 1. Homebrew (Common for both OS)
if command -v brew >/dev/null; then
    echo "Updating Homebrew & Casks..."
    brew update && brew upgrade && brew cleanup
    # Optional: brew cu -a -y (if brew-cask-upgrade is installed)
fi

# 2. Neovim Headless Update (The "Deep" update)
if command -v nvim >/dev/null; then
    echo "Updating Neovim Plugins & Mason Binaries..."
    # Update Lazy.nvim plugins
    nvim --headless "+Lazy! sync" +qa
    # Update Mason binaries (LSP, Linters, Formatters)
    nvim --headless -c "MasonUpdate" -c "qa"
fi

# 3. Zsh Plugins (Zap)
if [ -f "$HOME/.local/share/zap/zap.zsh" ]; then
    echo "Updating Zsh plugins (Zap)..."
    zsh -c "source $HOME/.local/share/zap/zap.zsh && zap update"
fi

# 4. Firmware (Linux only)
if [ "$OS" = "Linux" ] && command -v fwupdmgr >/dev/null; then
    echo "Checking for firmware updates..."
    sudo fwupdmgr get-updates || true
fi

echo "--- Maintenance completed successfully ---"