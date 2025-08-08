#!/usr/bin/env bash

# Exit on error, undefined variable, or failed command in a pipeline
set -euo pipefail

# Check if mise is installed
if ! command -v mise &>/dev/null; then
	echo "mise is not installed. Please install mise first."
	exit 1
fi

# Ensure mise environment is set up
CURRENT_SHELL=$(basename "$SHELL")
case "$CURRENT_SHELL" in
bash)
	eval "$(mise activate bash)"
	;;
zsh)
	eval "$(mise activate zsh)"
	;;
fish)
	mise activate fish | source
	;;
*)
	echo "Unsupported shell: $CURRENT_SHELL"
	exit 1
	;;
esac

# Install essential tools using mise
mise use -g bat
mise use -g delta
mise use -g difftastic
mise use -g fd
mise use -g fzf
mise use -g lazygit
mise use -g neovim@0.11.3
mise use -g node@lts
mise use -g ripgrep
mise use -g sd
mise use -g yazi
mise use -g zoxide

# Install essential npm packages
mise use -g npm:czg
