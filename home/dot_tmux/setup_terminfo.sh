#!/usr/bin/env bash
# setup_terminfo.sh
# Used for installing some terminfo files for tmux

set -euo pipefail

TERMINFO_DIR="$HOME/.terminfo"
TERMINFO_FOR_INSTALL="tmux-256color"
NCURSES_URL="https://invisible-island.net/archives/ncurses/ncurses-6.6.tar.gz"

# Make sure the terminfo directory exists
mkdir -p "$TERMINFO_DIR"

# Make a temporary directory for downloading terminfo source
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# Download the ncurses source tarball
curl -L "$NCURSES_URL" -o "$TEMP_DIR/ncurses.tar.gz"

# Extract the downloaded tarball
tar -xzf "$TEMP_DIR/ncurses.tar.gz" -C "$TEMP_DIR"

# Find the terminfo source file
TERMINFO_SRC=$(find "$TEMP_DIR" -name "terminfo.src" | head -n 1)

# Install the selected terminfo file to the terminfo directory
tic -x -e "$TERMINFO_FOR_INSTALL" -o "$TERMINFO_DIR" "$TERMINFO_SRC"
