#!/usr/bin/env bash
# install.sh
# Install dependencies(LSPs, formatters, linters, etc.)

# Exit on error, undefined variables, or pipe failures
set -euo pipefail

# ====================================================================
# Tools installed with mise
# ====================================================================

# Check if mise is available
if ! command -v mise &>/dev/null; then
	echo "mise is not installed. Please install it first."
else
	mise use -g lua-language-server
	mise use -g ruff
	mise use -g shellcheck
	mise use -g shfmt
	mise use -g stylua
	mise use -g taplo
fi

# =====================================================================
# Tools installed with npm
# =====================================================================

# Check if npm is available
if ! command -v npm &>/dev/null; then
	echo "npm is not installed. Please install it first."
else
	npm install -g bash-language-server
	npm install -g markdownlint-cli2
	npm install -g prettier
	npm install -g pyright
	npm install -g tree-sitter-cli
fi

# =====================================================================
# Tools installed with uv/pipx/pip
# =====================================================================

# Helper function to install pypi package
# Prioritizes uv, then pipx, then pip
install_pypi_tool() {
	if command -v uv &>/dev/null; then
		uv tool install "$1"
	elif command -v pipx &>/dev/null; then
		pipx install "$1"
	elif command -v pip &>/dev/null; then
		pip install --user "$1"
	else
		echo "No suitable Python package manager found for $1."
	fi
}

# Install pypi tools
# install_pypi_tool "ruff"
