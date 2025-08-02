#!/usr/bin/env bash

# This script sets up a new machine with a configuration managed by chezmoi.

# Ensure chezmoi are installed
if ! command -v chezmoi &>/dev/null; then
	echo "chezmoi is not installed. Please install it first."
	exit 1
fi

# Target repository containing the dotfiles
TARGET_REPO="https://github.com/yilinfang/dotfiles.git"
SOURCE_DIR="$HOME/.chezmoi/dotfiles"

# Get current script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Configuration file containing paths to apply
CONFIG_FILE="$SCRIPT_DIR/config.txt"

# Backup directory with timestamp
BACKUP_DIR="$HOME/.chezmoi/backup-$(date +%Y%m%d-%H%M%S)"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
	echo "Configuration file not found: $CONFIG_FILE"
	exit 1
fi

# Function to backup a file or directory
backup_path() {
	local path="$1"
	local expanded_path="${path/#\~/$HOME}"

	if [ -e "$expanded_path" ]; then
		echo "Backing up existing $path..."

		# Create backup directory if it doesn't exist
		mkdir -p "$BACKUP_DIR"

		# Calculate relative path from home directory
		local rel_path="${expanded_path#$HOME/}"
		local backup_target="$BACKUP_DIR/$rel_path"

		# Create parent directories in backup location
		mkdir -p "$(dirname "$backup_target")"

		# Copy the file or directory
		if [ -d "$expanded_path" ]; then
			cp -r "$expanded_path" "$backup_target"
			rm -rf "$expanded_path" # Remove original directory after backup
		else
			cp "$expanded_path" "$backup_target"
			rm "$expanded_path" # Remove original file after backup
		fi

		echo "Backed up to: $backup_target"
		return 0
	else
		echo "No existing file/directory found at $path, skipping backup."
		return 1
	fi
}

# Cleanup any existing chezmoi configuration
if [ -d "$HOME/.config/chezmoi" ]; then
	echo "Removing existing chezmoi config files..."
	rm -rf "$HOME/.config/chezmoi"
fi

if [ -d "$HOME/.local/share/chezmoi" ]; then
	echo "Removing existing chezmoi configuration..."
	rm -rf "$HOME/.local/share/chezmoi"
fi

# Initialize chezmoi with the target repository
echo "Initializing chezmoi with the repository: $TARGET_REPO"
chezmoi init "$TARGET_REPO" -S "$SOURCE_DIR"

# Track if any backups were made
BACKUP_MADE=false

# Apply selected dotfiles from configuration file
while IFS= read -r path || [ -n "$path" ]; do
	# Skip empty lines and comments
	if [[ -z "$path" || "$path" =~ ^[[:space:]]*# ]]; then
		continue
	fi

	# Trim whitespace
	path=$(echo "$path" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

	# Backup existing files if they exist
	if backup_path "$path"; then
		BACKUP_MADE=true
	fi

	echo "Applying $path..."
	chezmoi apply -r "$path"
done <"$CONFIG_FILE"

# Show backup information
if [ "$BACKUP_MADE" = true ]; then
	echo ""
	echo "Backups created in: $BACKUP_DIR"
	echo "You can restore any file by copying it back from the backup directory."
	echo "To remove backups later: rm -rf '$BACKUP_DIR'"
else
	echo "No existing configurations found, no backups needed."
fi

# Finish setup
echo "Setup complete!"
