#!/usr/bin/env bash

# Get the directory where the script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Load utility functions
source "$DOTFILES_DIR/utils.sh"

# Fish configuration
create_link "$DOTFILES_DIR/fish" "$HOME/.config/fish"

# Ghostty configuration
create_link "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"

# Git configuration
create_link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Neovim configuration
create_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Starship configuration
create_link "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# Vim configuration
create_link "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

# Yazi configuration
bash "$DOTFILES_DIR/yazi/install.sh"

# Zellij configuration
bash "$DOTFILES_DIR/zellij/install.sh"