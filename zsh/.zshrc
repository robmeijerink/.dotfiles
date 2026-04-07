#!/bin/zsh
# =========================================================
# ZSH Configuration - Rob Meijerink
# =========================================================

# --- 1. Environment & Exports (CRITICAL: Load first) ---
# Load your paths and env vars so all subsequent tools see them
[ -f "$HOME/.config/zsh/exports.zsh" ] && source "$HOME/.config/zsh/exports.zsh"

# Linuxbrew Path Injection
if [[ "$OSTYPE" == "linux-gnu"* && -d "/home/linuxbrew/.linuxbrew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Pre-init asdf
if [ -f "$HOME/.asdf/asdf.sh" ]; then
    ASDF_SH="$HOME/.asdf/asdf.sh"
elif [ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]; then
    ASDF_SH="/opt/homebrew/opt/asdf/libexec/asdf.sh"
elif [ -f "/home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh" ]; then
    ASDF_SH="/home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.sh"
fi

if [[ -n "$ASDF_SH" ]]; then
    . "$ASDF_SH"
    # Inject completions before compinit
    [[ -n "$ASDF_DIR" ]] && fpath=(${ASDF_DIR}/completions $fpath)
fi

# --- 2. Plugin Manager (Zap) ---
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# --- 3. VI-Mode Hook (Must be defined BEFORE the plugin is loaded) ---
function zvm_after_init() {
    # Substring Search Bindings
    zvm_bindkey vicmd 'k' history-substring-search-up
    zvm_bindkey vicmd 'j' history-substring-search-down

    # FZF & Custom logic
    bindkey '^r' fzf-history-widget
    bindkey '^ ' autosuggest-accept
}

# --- 4. Plugins ---
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-completions"

# --- RESTORED: Local Logic & Custom Scripts ---
plug "$HOME/.config/zsh/plugins/dirpersist.zsh"
plug "$HOME/.config/zsh/plugins/ssh-load.zsh"

# Productivity & Search
plug "zap-zsh/fzf"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "jeffreytse/zsh-vi-mode"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"

# --- 5. History & Behavior ---
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# Source .profile for any legacy environment variables
[ -r "$HOME/.profile" ] && source "$HOME/.profile"

# --- 6. Version Managers & Logic ---
if command -v fnm &> /dev/null; then
    eval "$(fnm env --use-on-cd)"
fi

# FZF initialization (Modern way)
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
fi

# Keybindings
bindkey -s '^f' "$HOME/.local/scripts/tmux-sessionizer\n"

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

# Aliases
[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"

# --- 7. Final Cleanup (O(1) cached startup) ---
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(N.m-1) ]]; then
    compinit -C
else
    compinit -i
fi

# Behavior tweaks
unsetopt MENU_COMPLETE
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
