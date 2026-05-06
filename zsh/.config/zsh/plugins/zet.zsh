# =========================================================
# Plugin: Obsidian Zettelkasten Inbox Generator
# Description: Quick note creation in Obsidian Inbox via Neovim
# =========================================================

zet() {
  local target_dir="$HOME/Dropbox/Obsidian/RobMainVault/10_Inbox"
  local date_prefix=$(date +%Y-%m-%d-%H%M)
  local filename=""

  # Check if a title argument was provided
  if [ -z "$1" ]; then
    filename="$date_prefix-note.md"
  else
    # Convert title to lowercase and replace spaces with hyphens
    local formatted_title=$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    filename="$date_prefix-$formatted_title.md"
  fi

  # Open the file in Neovim
  nvim "$target_dir/$filename"
}
