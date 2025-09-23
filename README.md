# Prerequisites

Before Installation:

0. `apt install build-essential`
0. `bin` folders -> `mkdir ~/bin ~/.local/bin`

1. pix -> `apt install pipx`
2. nvm
    1. `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/vX.X.X/install.sh | bash`
    2. `nvm install XX`
    3. `nvm use XX`

3. tmux -> `apt install tmux`
4. install nvim
    1. `mkdir -p ~/prog/nvim`
    2. `curl -L -o ~/prog/nvim/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage`
    3. `chmod ug+x ~/prog/nvim/nvim.appimage`
    4. `ln -sv ~/prog/nvim/nvim.appimage ~/bin/nvim`

## Overview

### Config List

- Terminal Emulator [WezTerm](https://wezfurlong.org/wezterm/index.html). Alternatives could be *Kitty*, *Contour*, *Ghostty*
- Terminal Multiplexer [Tmux](https://github.com/tmux/tmux/wiki). Alternatives *Zellij*
- Terminal File Explorer [Yazi](https://yazi-rs.github.io/). WARN: currently can't open PDFs and Images with default application

- Zsh theme [p10k](https://github.com/romkatv/powerlevel10k)

### Nvim

#### General

![Vim Cheat Sheet](http://www.viemu.com/vi-vim-cheat-sheet.gif)

#### Plugins

## Tmux
