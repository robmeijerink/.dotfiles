# .dotfiles

- ZSH configuration
- Alacritty Terminal configuration
- Snippets of my Terminal profile / aliases for usage in Docker containers
- .vimrc with basic settings for regular vim
- Neovim .lua config files with more advanced settings and plugins
- Window tiling manager configurations of Aerospace (macOS) and Sway (Wayland / Fedora)
- Sway extension configurations: waybar, wofi, mako etc.
- tmux configuration
- tmux-sessionizer
- fzf bindings for fuzzy finding in the terminal

The configuration can be installed with GNU stow. I made a script to install the dependencies on MacOs, Linux and WSL. The script is called setup.sh and is located in the root of this repository. You can run it with `./setup.sh`. You can also install the dependencies manually. The dependencies are listed in the setup.sh script. To make it easier I decided to use brew to install the dependencies, so it works with both Linux and MacOs, but you can use any package manager you want, like: apt, yum, pacman etc.

## Description
- My Font: Fira Code Nerd Font: https://www.nerdfonts.com/font-downloads

### Neovim

I use Neovim daily for web development at work and side-projects in PHP, Rust, Go, Javascript / Typescript, CSS / scss etc.

- The nvim setup needs nodejs and npm installed.
- The nvim and zsh setup need some dependencies. If you use Linux or WSL, you can run the setup.sh script to install these dependencies. If you use MacOs, you can easily install the dependencies by using Homebrew.
- Stow the nvim folder.
- Use Lazy.nvim to install and setup the nvim plugins.
- Install the nvim plugins: Sync the plugins config with :Lazy.
- The after/plugin folder contains the customizations you will need most, like: theme, snippets and keymaps.

A special thanks to [ThePrimeagen](https://github.com/ThePrimeagen/) for getting me into Vim, improving my terminal workflow and boosting my productivity!

### Num row swap (optional)

Optional: types the symbols (`! @ # $ % ^ & * ( )`) on the number row without Shift and the digits with Shift. Ctrl/Alt/Cmd/Super + digit are not swapped (shortcuts like Ctrl+1 keep working). `setup.sh` does **not** enable this, follow the steps below.

**macOS (Karabiner-Elements)**
1. Stow the `karabiner` folder (`setup.sh` already does this); it only makes the rules available.
2. Open Karabiner-Elements > Complex Modifications > Add predefined rule.
3. Enable the "Swap ... " rules for 1-9 and 0 (use "Enable all").
4. To undo: remove the rules in the same screen.

**Fedora (Sway)**
1. Stow the layout: `stow xkb` (installs `~/.config/xkb/{symbols,types,rules}`).
2. Create `~/.config/sway/conf.d/numswap.conf` (git-ignored) with:
   ```
   input "type:keyboard" {
       xkb_layout numswap
   }
   ```
   Do not set `xkb_variant`: `numswap` already includes `us(altgr-intl)`, so AltGr characters (e.g. AltGr+5 = Euro) keep working.
3. Run `swaymsg reload` and check `swaymsg -t get_inputs`.
4. To undo: delete `numswap.conf` and run `swaymsg reload`.

The Sway workspace bindings use `bindcode`, so they work with and without the swap.

### ZSH

I stopped using OhMyZSH, because I wanted something leaner and snappier. I don't use most of the stuff OhMyZSH offers, so I started using this simple ZSH configuration. This config also supports plugins and has the zsh aliases I use most. It is much less code and has all the things I wanted from OhMyZSH. It supports auto-complete, syntax highlighting and better formatting. The performance of this setup in my Alacritty terminal is great!

- Install zsh with your package manager of choice, like Homebrew or apt.
- Install bat and eza with your package manager.
- [Install Zap](https://github.com/zap-zsh/zap) by running the the install command from the docs. Zap is a simple zsh plugin manager made by the great [ChristianChiarulli](https://github.com/ChristianChiarulli).
- Stow the zsh folder.

##### Workflow

- Launch Alacritty or your preferred terminal.
- Press Ctrl-F to fuzzy find your workspace folder.
- Press enter to launch a new tmux session in your selected folder.
- Launch nvim
- Build something great!
