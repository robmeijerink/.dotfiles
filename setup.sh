#!/usr/bin/env bash

# Run this file once to set up some dependencies and folders the neovim config needs.

npm i -g neovim intelephense typescript typescript-language-server prettier emmet-ls vscode-langservers-extracted blade-formatter

brew install unzip
brew install ripgrep
brew install fd-find
brew install fzf
brew install php-codesniffer
brew install chafa
brew install jq

mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/backup
mkdir -p ~/.vim/tmp/swap

echo "Run :checkhealth for additional dependency info"

# Shell
brew install bat
brew install -y exa

# Use stow after installation to setup all config files, example: stow zsh.
echo "Installed!"
