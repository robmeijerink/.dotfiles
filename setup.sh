#!/usr/bin/env bash

# Run this file once to set up some dependencies and folders the neovim config needs.

mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/backup
mkdir -p ~/.vim/tmp/swap

npm i -g neovim intelephense typescript typescript-language-server prettier emmet-ls vscode-langservers-extracted blade-formatter

sudo apt install -y fd-find

brew install ripgrep
brew install fzf
brew install php-code-sniffer
brew install chafa
brew install jq

# Shell
brew install zoxide
brew install bat
brew install exa
brew install git-delta

brew install gum
brew install ms-jpq/sad/sad

echo "Run :checkhealth for additional dependency info"

# Use stow after installation to setup all config files, or set them seperately with this example: stow zsh.
echo "Installed!"
