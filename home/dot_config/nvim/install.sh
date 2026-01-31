#!/usr/bin/env bash

# install.sh
# Install dependencies(LSPs, formatters, linters, etc.) with mise
# NOTE: Deprecated but kept for reference

# Exit on error, undefined variables, or pipe failures
set -euo pipefail

# Check if mise is available
if ! command -v mise &>/dev/null; then
	echo "mise is not installed. Please install it first."
else
	mise use -g lua-language-server
	mise use -g shellcheck
	mise use -g shfmt
	mise use -g stylua
	mise use -g taplo

	# Check if npm is available
	if ! command -v npm &>/dev/null; then
		echo "npm is not installed. Skipping npm packages."
	else
		mise use -g npm:bash-language-server
		mise use -g npm:prettier
		mise use -g npm:pyright
		mise use -g npm:tree-sitter-cli
	fi

	# Check if pipx or uvx is available
	if ! command -v pipx &>/dev/null && ! command -v uvx &>/dev/null; then
		echo "pipx or uvx is not installed. Skipping python packages."
	else
		mise use -g pipx:ruff
	fi
fi
