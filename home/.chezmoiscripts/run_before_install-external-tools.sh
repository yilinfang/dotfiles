#!/usr/bin/env bash
# This script is used to install some useful tools to ~/.local/bin/
# This script will be run when 'chezmoi apply' is executed

set -euo pipefail

TARGET_DIR="$HOME/.local/bin"
mkdir -p "$TARGET_DIR"

FW_PATH="$TARGET_DIR/fw"
FW_URL="https://raw.githubusercontent.com/yilinfang/fw/refs/heads/main/fw"
SMART_RM_PATH="$TARGET_DIR/smart-rm"
SMART_RM_URL="https://raw.githubusercontent.com/yilinfang/smart-rm/refs/heads/main/smart-rm"

# If wget is available
if command -v wget &>/dev/null; then
	wget -q "$FW_URL" -O "$FW_PATH"
	chmod +x "$FW_PATH"
	wget -q "$SMART_RM_URL" -O "$SMART_RM_PATH"
	chmod +x "$SMART_RM_PATH"
elif command -v curl &>/dev/null; then
	curl -sSL "$FW_URL" -o "$FW_PATH"
	chmod +x "$FW_PATH"
	curl -sSL "$SMART_RM_URL" -o "$SMART_RM_PATH"
	chmod +x "$SMART_RM_PATH"
else
	echo "Error: Neither wget nor curl is installed. Please install one of them to proceed."
	exit 1
fi
