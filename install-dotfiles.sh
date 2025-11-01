#!/usr/bin/env bash

# ZSH
[ ! -f ~/.zshrc ] && ln -sv ~/.dotfiles/.zshrc ~/.zshrc || echo ".zshrc already set"
[ ! -f '/usr/bin/zsh' ] && sudo apt install zsh -y || echo "zsh already installed"
[ ! -d "${HOME}/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || echo "oh-my-zsh already installed"
[ -f ~/.zshrc.pre-oh-my-zsh ] && rm ~/.zshrc && rm ~/.zshrc.pre-oh-my-zsh
[ ! -f ~/.zshrc ] && ln -sv ~/.dotfiles/.zshrc ~/.zshrc || echo ".zshrc already set"
[ ! -d "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k" ] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" || echo "powerlevel10k theme already exists"
[ ! -f "${HOME}/.p10k.zsh" ] && ln -sv ~/.dotfiles/.p10k.zsh ~/.p10k.zsh

# VIM, NVIM and TMUX
[ ! -f ~/.tmux.conf ] && ln -sv ~/.dotfiles/.tmux.conf ~/.tmux.conf || echo "tmux.conf already set"
[ ! -d ~/.config/nvim ] && ln -sv ~/.dotfiles/nvim ~/.config/nvim || echo "nvim config already exists"

[ ! -f ~/.vimrc ] && ln -sv ~/.dotfiles/vim/.vimrc ~/.vimrc || echo ".vimrc already set"
[ ! -f ~/.vimrcprivate ] &&  ln -sv ~/.dotfiles/vim/.vimrcprivate ~/.vimrcprivate || echo ".vimrcprivate already set"


# LSP prerequisites

# npm LSPs
npm install -g bun typescript vscode-langservers-extracted emmet-ls @vue/language-server @vue/typescript-plugin browser-sync bash-language-server yaml-language-server pyright

# pip LSPs
command -v pipx &> /dev/null && pipx install cmake-language-server
command -v pipx &> /dev/null && pipx install ninja
command -v pipx &> /dev/null && pipx install ruff
command -v pipx &> /dev/null && pipx install tldr
command -v pipx &> /dev/null && pipx install virtualenv

# SETTINGS

# C++ settings
[ ! -f ~/.config/clangd/config.yaml ] &&ln -sv ~/.dotfiles/.clang-format ~/.config/clangd/config.yaml || echo "clangd config already exists"


# OTHER TOOLS
#
# WezTerm
[ ! -f ~/.wezterm.lua ] && ln -sv ~/.dotfiles/.wezterm.lua ~/.wezterm.lua || echo "wezterm config already exists"

[ ! -d ~/.terminfo ] && tempfile=$(mktemp) \
  && curl -o "$tempfile" https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo "$tempfile" \
  && rm "$tempfile"

# Kitty
# [ ! -d ~/.confg/kitty ] && ln -sv ~/.dotfiles/kitty ~/.config/kitty || echo "kitty config already exists"

# Ghostty
[ ! -d ~/.config/ghostty ] && ln -sv ~/.dotfiles/ghostty ~/.config/ghostty || echo "ghostty config already exists"

# Yazi
[ ! -d ~/.config/yazi ] && ln -sv ~/.dotfiles/yazi ~/.config/yazi || echo "yazi already exists"

# Presentterm
# [ ! -d ~/.config/presentterm ] && ln -sv ~/.dotfiles/presentterm ~/.config/presenterm || echo "presenterm already exists"

# Cheat Sheets
[ ! -f ~/bin/cht ] && ln -sv ~/.dotfiles/scripts/cht.sh ~/bin/cht || echo "cht already exists"

