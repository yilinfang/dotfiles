#!/usr/bin/env bash

# This script sets up a new machine with a configuration managed by chezmoi.

# Ensure chezmoi and age are installed
if ! command -v chezmoi &>/dev/null; then
	echo "chezmoi is not installed. Please install it first."
	exit 1
fi

# Update chezmoi source dir
chezmoi update --apply=false

# Initialize chezmoi if there are some updates in chezmoi configuration
chezmoi init --apply=false

# Get current script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Configuration file containing paths to apply
CONFIG_FILE="$SCRIPT_DIR/config.txt"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
	echo "Configuration file not found: $CONFIG_FILE"
	exit 1
fi

# Apply selected dotfiles from configuration file
while IFS= read -r path || [ -n "$path" ]; do
	# Skip empty lines
	if [[ -z "$path" ]]; then
		continue
	fi

	# Trim whitespace
	path=$(echo "$path" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

	echo "Applying $path..."
	chezmoi apply -r "$path"
done <"$CONFIG_FILE"

# Finish update
echo "Update complete!"
