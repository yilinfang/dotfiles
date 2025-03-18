#!/usr/bin/env bash

TMUX_CONFIG_REPO="https://github.com/yilinfang/.tmux.git"
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMUX_CONFIG_DIR="$CURRENT_DIR/.tmux"

rm -rf "$TMUX_CONFIG_DIR"
mkdir -p "$TMUX_CONFIG_DIR"

# Clone the tmux configuration repository
git clone "$TMUX_CONFIG_REPO" "$TMUX_CONFIG_DIR"

# Check create_link function
if ! type create_link &>/dev/null; then
    if [ ! -f "$CURRENT_DIR/../utils.sh" ]; then
        echo "Error: utils.sh not found"
        exit 1
    fi
    source "$CURRENT_DIR/../utils.sh"
fi

create_link "$TMUX_CONFIG_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_link "$TMUX_CONFIG_DIR/.tmux.conf.local" "$HOME/.tmux.conf.local"
