create_link() {
  source="$1"
  target="$2"

  # Check if source file exists
  if [ ! -e "$source" ]; then
    echo "Error: Source file $source not found."
    return
  fi

  # Check if the target already exists and is not a symlink
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "File $target found. Backing up existing file..."
    # Create backup with timestamp
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    backup_file="${target}.bak_${TIMESTAMP}"
    mv "$target" "$backup_file"
    echo "Backed up $target to $backup_file"
  elif [ -L "$target" ]; then
    echo "Symlink $target found. Removing existing symlink..."
    # Remove existing symlink
    rm "$target"
    echo "Removed existing symlink: $target"
  fi

  # Create symbolic link
  ln -s "$source" "$target"
  echo "Created symbolic link: $target -> $source"
}
