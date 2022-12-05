# Dotfiles

- ZSH configuration
- Alacritty Terminal configuration
- Snippets of my Terminal profile / aliases for usage in Docker containers
- .vimrc with basic settings for regular vim
- NeoVim .lua config files with more advanced settings and plugins
- tmux configuration
- tmux-sessionizer
- fzf bindings for fuzzy finding in the terminal

The configuration can be installed with GNU stow.

# Other
- My Font: Fira Code Nerd Font: https://www.nerdfonts.com/font-downloads

### NeoVim

I use NeoVim daily for web development at work and side-projects in PHP, Rust, Go, Javascript / Typescript, CSS / scss etc.

- The nvim setup needs nodejs and npm installed.
- The nvim and zsh setup need some dependencies. If you use Linux or WSL, you can run the setup.sh script to install these dependencies. If you use MacOs, you can easily install the dependencies by using Homebrew.
- Stow the nvim folder.
- Use Packer to install and setup the nvim plugins.
- Install the nvim plugins: Sync the Packer config with :PackerSync.
- The after/plugin folder contains the customizations you will need most, like: theme, snippets and keymaps.

A special thanks to [ThePrimeagen](https://github.com/ThePrimeagen/) for getting me into Vim, improving my terminal workflow and boosting my productivity!

### ZSH

I stopped using OhMyZSH, because I wanted something leaner and snappier. I don't use most of the stuff OhMyZSH offers, so I started using this simple ZSH configuration. This config also supports plugins and has the zsh aliases I use most. It is much less code and has all the things I wanted from OhMyZSH. The performance of this setup in my Alacritty terminal is great!

- Install zsh with your package manager of choice, like Homebrew or apt.
- [Install Zap](https://github.com/zap-zsh/zap) by running the command on the install command from the docs. Zap is a simple zsh plugin manager made by the great [ChristianChiarulli](https://github.com/ChristianChiarulli).
- Stow the zsh folder.
