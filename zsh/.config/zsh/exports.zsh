#!/bin/sh
# Github Verified commits with GPG
export GPG_TTY=$(tty)
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"
export PATH="$HOME/.local/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/scripts:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH # MacOS
export PATH=$HOME/.config/composer/vendor/bin:$PATH # Linux
export PATH=$HOME/go/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
# Zoxide
eval "$(zoxide init zsh)"
