#!/usr/bin/env bash

YAZI_CONFIG_REPO="https://github.com/yilinfang/yazi.git"
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
YAZI_CONFIG_DIR="$CURRENT_DIR/yazi"

rm -rf "$YAZI_CONFIG_DIR"
mkdir -p "$YAZI_CONFIG_DIR"

# Clone the Yazi configuration repository
git clone "$YAZI_CONFIG_REPO" "$YAZI_CONFIG_DIR"

# Check create_link function
if ! type create_link &>/dev/null; then
    if [ ! -f "$CURRENT_DIR/../utils.sh" ]; then
        echo "Error: utils.sh not found"
        exit 1
    fi
    source "$CURRENT_DIR/../utils.sh"
fi

create_link "$CURRENT_DIR/yazi" "$HOME/.config/yazi"