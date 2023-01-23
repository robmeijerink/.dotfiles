#!/usr/bin/env bash

# Run this file once to set up some dependencies and folders the neovim config needs.

npm i -g neovim intelephense typescript typescript-language-server prettier emmet-ls vscode-langservers-extracted blade-formatter

sudo apt install -y unzip
sudo apt install -y ripgrep
sudo apt install -y fd-find
sudo apt install -y fzf
sudo apt install -y php-codesniffer
sudo apt install -y chafa
sudo apt install -y jq

mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/backup
mkdir -p ~/.vim/tmp/swap

echo "Run :checkhealth for additional dependency info"

# Shell
sudo apt install -y bat
sudo apt install -y exa

# Use stow after installation to setup all config files, example: stow zsh.
echo "Installed!"
