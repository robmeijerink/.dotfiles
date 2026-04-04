#!/bin/zsh
# =========================================================
# ZSH Configuration - Rob Meijerink 
# =========================================================

# --- 1. Plugin Manager (Zap) ---
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# --- 2. Environment & History ---
HISTFILE=~/.zsh_history
[ -r "$HOME/.profile" ] && source "$HOME/.profile"

# --- 3. Modular Config Sourcing ---
# Exports first to ensure PATH is correctly built
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/aliases.zsh"

# --- 4. Plugins (Zap) ---
plug "$HOME/.config/zsh/plugins/dirpersist.zsh"
plug "$HOME/.config/zsh/plugins/ssh-load.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zap-zsh/fzf"
plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"

# --- 5. Fast Node Manager (FNM) ---
# High-performance Node version management (Rust-based)
if command -v fnm &> /dev/null; then
  # --use-on-cd: Automatically switches node version based on .node-version or .nvmrc
  eval "$(fnm env --use-on-cd)"
fi

# --- 6. Keybindings & Productivity ---
# Accept autosuggestion with Ctrl + Space
bindkey '^ ' autosuggest-accept

# Fast project switching via tmux-sessionizer (Fzf-powered)
bindkey -s '^f' "tmux-sessionizer\n"

# Standard FZF integration
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