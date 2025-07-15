#!/usr/bin/env bash

# Exit on error, undefined variable, or failed command in a pipeline
set -euo pipefail

# Check if mise is installed
if ! command -v mise &>/dev/null; then
	echo "mise is not installed. Please install mise first."
	exit 1
fi

# Install essential tools using mise
mise use -g bat
mise use -g delta
mise use -g difftastic
mise use -g fd
mise use -g fzf
mise use -g lazygit
mise use -g neovim@0.11.3
mise use -g node
mise use -g "npm:czg"
mise use -g ripgrep
mise use -g yazi
mise use -g zellij@0.42.2
mise use -g zoxide
