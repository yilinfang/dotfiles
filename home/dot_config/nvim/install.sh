#!/usr/bin/env bash
# install.sh
# Install dependencies(LSPs, formatters, linters, etc.) with mise

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

	# Check if node is available
	if ! command -v node &>/dev/null; then
		echo "Node.js is not installed. Please install it first."
	else
		mise use -g npm:bash-language-server
		mise use -g npm:prettier
		mise use -g npm:pyright
		mise use -g npm:tree-sitter-cli
	fi

	# Check if uvx or pipx is available
	if ! command -v uvx &>/dev/null && ! command -v pipx &>/dev/null; then
		echo "Neither uvx nor pipx is installed. Please install one of them first."
	else
		mise use -g pipx:ruff
	fi
fi
