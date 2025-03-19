#!/usr/bin/env bash

# Get the directory where the script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Load utility functions
source "$DOTFILES_DIR/utils.sh"

# Git configuration
create_link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Vim configuration
create_link "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

# Tmux configuration
bash "$DOTFILES_DIR/tmux/install.sh"

# Fish configuration
create_link "$DOTFILES_DIR/fish" "$HOME/.config/fish"

# WezTerm configuration
create_link "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"

# Starship configuration
create_link "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# Yazi configuration
bash "$DOTFILES_DIR/yazi/install.sh"

# Zellij configuration
bash "$DOTFILES_DIR/zellij/install.sh"
