#!/usr/bin/env bash

ZELLIJ_CONFIG_REPO="https://github.com/yilinfang/zellij.git"
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZELLIJ_CONFIG_DIR="$CURRENT_DIR/zellij"

rm -rf "$ZELLIJ_CONFIG_DIR"
mkdir -p "$ZELLIJ_CONFIG_DIR"

# Clone the Zellij configuration repository
git clone "$ZELLIJ_CONFIG_REPO" "$ZELLIJ_CONFIG_DIR"

# Check create_link function
if ! type create_link &>/dev/null; then
    if [ ! -f "$CURRENT_DIR/../utils.sh" ]; then
        echo "Error: utils.sh not found"
        exit 1
    fi
    source "$CURRENT_DIR/../utils.sh"
fi

create_link "$CURRENT_DIR/zellij" "$HOME/.config/zellij"