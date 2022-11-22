# Dotfiles

- Snippets of my Terminal profile / aliases
- .vimrc with basic settings for regular vim
- NeoVim .lua config files with more advanced settings and plugins
- tmux configuration
- tmux-sessionizer
- fzf bindings for fuzzy finding in the terminal

# Other
- My Font: FiraCode Nerd Font Regular: https://www.nerdfonts.com/font-downloads

### NeoVim

I use NeoVim daily for web development and sideprojects in PHP, Rust, Go, Javascript / Typscript, CSS / scss etc.

- The nvim setup needs nodejs and npm installed.
- The nvim setup needs some dependencies. There is an install script called deps in the ./config/nvim folder. If you use Linux, MacOs or WSL. You can run this script first to install these dependencies.
- Use the install script to setup nvim and its config files.
- Use Packer to install and setup the nvim plugins.
- Sync the Packer config with :PackerSync.
- The after/plugin folder has the customizations you will need most, like: theme, snippets and keymaps.
