#!/usr/bin/env bash

# Script for installing essential LSPs, linters and formatters for neovim via mise.
# This script uses mise (https://mise.jdx.dev/) to manage and install tools.
# Tools are installed using mise's specific backends: npm, pipx, cargo, and asdf.

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
	echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
	echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
	echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
	echo -e "${RED}[ERROR]${NC} $1"
}

# Check if mise is installed
check_mise() {
	if ! command -v mise &>/dev/null; then
		log_error "mise is not installed. Please install mise first:"
		echo "  curl https://mise.run | sh"
		exit 1
	fi
	log_success "mise is installed"
}

# Install a tool via mise with specific backend
install_with_backend() {
	local backend=$1
	local tool=$2
	log_info "Installing $tool via mise ($backend backend)..."
	if mise use -g "$backend:$tool" 2>/dev/null; then
		log_success "$tool installed successfully"
	else
		log_warn "Failed to install $tool via $backend backend"
		return 1
	fi
}

# Install using default backend (default)
install() {
	local tool=$1
	log_info "Installing $tool via mise (default backend)..."
	if mise use -g "$tool" 2>/dev/null; then
		log_success "$tool installed successfully"
	else
		log_warn "Failed to install $tool via asdf backend"
		return 1
	fi
}

# Main installation function
main() {
	log_info "Starting installation of Neovim development tools via mise..."
	check_mise

	# ============================================
	# LSPs (Language Servers)
	# ============================================
	log_info "Installing LSPs..."
	install "lua-language-server" || true
	install "ruff" || true
	install_with_backend "pipx" "basedpyright" || true
	install_with_backend "npm" "bash-language-server" || true

	# ============================================
	# Linters
	# ============================================
	log_info "Installing Linters..."
	install "shellcheck" || true

	# ============================================
	# Formatters
	# ============================================
	log_info "Installing Formatters..."
	install "stylua" || true
	install "shfmt" || true
	install "taplo" || true
	install_with_backend "npm" "prettier" || true

	log_success "Installation complete!"
	log_info "Run 'mise list' to see installed tools."
}

# Run main function
main "$@"
