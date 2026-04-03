#!/usr/bin/env bash
# Description: Unified maintenance routine for Linux and macOS.
# Usage: Execute directly. Will ask for sudo if required.

set -e

# Detect Operating System
OS="$(uname -s)"

echo "Starting system maintenance for $OS..."

if [ "$OS" = "Linux" ]; then
    # Ubuntu / Debian architecture
    echo "Running APT and Snap updates..."
    sudo apt-get update
    sudo apt-get upgrade
    sudo snap refresh
    sudo apt-get autoremove --purge
    sudo apt-get clean

    if command -v brew >/dev/null 2>&1; then
        echo "Running Homebrew on Linux updates..."
        brew update
        brew upgrade
        brew cleanup
    else
        echo "Warning: Homebrew on Linux not found."
    fi

elif [ "$OS" = "Darwin" ]; then
    # macOS architecture
    if command -v brew >/dev/null 2>&1; then
        echo "Running Homebrew updates..."
        brew update
        brew upgrade
        brew cleanup
    else
        echo "Warning: Homebrew not found."
    fi

    # Check for available App Store updates without installing them
    if command -v mas >/dev/null 2>&1; then
        # brew install mas
        echo "Checking Mac App Store updates..."
        # List outdated apps
        mas outdated

        # Example of targeted updating:
        # Only update specific, low-risk tools by their Apple ID
        # mas upgrade 1480068668 # Messenger
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi

echo "Maintenance completed successfully."
