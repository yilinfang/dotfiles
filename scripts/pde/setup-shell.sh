#!/usr/bin/env bash

# Exit on error, undefined variables, or pipe failures.
set -euo pipefail

# --- Configuration ---
# Find the chezmoi source path, then locate the 'init' subdirectory.
CHEZMOI_INIT_DIR="$(chezmoi source-path)/scripts/init"

# --- Define the configuration snippets for each shell ---

BASH_CONFIG_SNIPPET=$(
	cat <<EOF
if [ -f "${CHEZMOI_INIT_DIR}/init.sh" ]; then
    source "${CHEZMOI_INIT_DIR}/init.sh"
fi
EOF
)

ZSH_CONFIG_SNIPPET=$(
	cat <<EOF
if [ -f "${CHEZMOI_INIT_DIR}/init.zsh" ]; then
    source "${CHEZMOI_INIT_DIR}/init.zsh"
fi
EOF
)

FISH_CONFIG_SNIPPET=$(
	cat <<EOF
if test -f "${CHEZMOI_INIT_DIR}/init.fish"
    source "${CHEZMOI_INIT_DIR}/init.fish"
end
EOF
)

# --- Main Logic ---

add_config() {
	local config_file="$1"
	local snippet="$2"
	local marker_line
	marker_line=$(echo "$snippet" | head -n 1)
	if [ ! -f "$config_file" ]; then touch "$config_file"; fi
	if grep -qF -- "$marker_line" "$config_file"; then
		echo "Setup: Configuration already exists in ${config_file}."
	else
		echo "Setup: Adding shell configuration to ${config_file}..."
		printf "\n%s\n" "$snippet" >>"$config_file"
	fi
}

current_shell=$(basename "${SHELL}")
echo "Setup: Detected default shell: ${current_shell}"
case "${current_shell}" in
bash) add_config "${HOME}/.bashrc" "$BASH_CONFIG_SNIPPET" ;;
zsh) add_config "${ZDOTDIR:-$HOME}/.zshrc" "$ZSH_CONFIG_SNIPPET" ;;
fish)
	config_file="${HOME}/.config/fish/config.fish"
	mkdir -p "$(dirname "$config_file")"
	add_config "$config_file" "$FISH_CONFIG_SNIPPET"
	;;
*) echo "Setup: Unsupported shell ('${current_shell}')." ;;
esac
