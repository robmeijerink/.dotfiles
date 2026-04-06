#!/bin/zsh
# =========================================================
# ZSH Configuration - Rob Meijerink
# Finalized for Path Reliability and Plugin Performance
# =========================================================

# --- 1. Plugin Manager (Zap) ---
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# --- 2. Environment & History ---
HISTFILE=~/.zsh_history
[ -r "$HOME/.profile" ] && source "$HOME/.profile"

# --- 3. Plugins (Zap) ---
# Core Extensions
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-completions"

# Local Logic & Custom Scripts
plug "$HOME/.config/zsh/plugins/dirpersist.zsh"
plug "$HOME/.config/zsh/plugins/ssh-load.zsh"

# Productivity & Search
plug "zap-zsh/fzf"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-history-substring-search"
plug "hlissner/zsh-autopair"

# The "Vim-Feel" (Crucial for Neovim users)
plug "jeffreytse/zsh-vi-mode"

# UI & Feedback (Always load these last)
plug "zsh-users/zsh-syntax-highlighting"

# --- 4. Modular Config Sourcing ---
# CRITICAL: We source exports LAST to ensure it overrides any PATH
# pollution introduced by Zap or other plugins during the boot sequence.
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/exports.zsh"

# --- 5. Keybindings & Productivity ---
# Accept autosuggestion with Ctrl + Space
bindkey '^ ' autosuggest-accept

# Fast project switching via tmux-sessionizer (Fzf-powered)
# Using 'tmux-sessionizer' directly as it is now guaranteed in $PATH
bindkey -s '^f' "$HOME/.local/scripts/tmux-sessionizer\n"

# Standard FZF integration (if present)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fancy-ctrl-z: Toggle between backgrounded process and shell
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# ============================================================================
# Command History & Fuzzy Search (fzf)
# ============================================================================

# 1. Activate fzf keybindings (including Ctrl+R and Ctrl+T)
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

# 2. Forceer Ctrl+R terug, óók als Vi-mode het probeert te overschrijven
bindkey '^r' fzf-history-widget

# --- 6. Final Cleanup ---
# Ensure completions are up to date after all plugins are loaded
autoload -Uz compinit
compinit