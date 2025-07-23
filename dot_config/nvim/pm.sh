#!/usr/bin/env bash
# pm.sh
# A minimal plugin manager for neovim

# Exit on error, undefined variables, or pipe failures
set -euo pipefail

NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
NVIM_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
PACKAGE_DIR="${NVIM_DATA_DIR}/site/pack/plugins"
LOCK_FILE="${NVIM_CONFIG_DIR}/plugins.lock"

# Ensure directories exist
mkdir -p "${PACKAGE_DIR}/start" "${PACKAGE_DIR}/opt" "$NVIM_CONFIG_DIR"

# Function to get the default branch of a repository
get_default_branch() {
	local repo="$1"
	local default_branch

	# Use git ls-remote to get the default branch without cloning
	default_branch=$(git ls-remote --symref "https://${repo}.git" HEAD | head -1 | sed 's/^ref: refs\/heads\///' | sed 's/\tHEAD$//')

	if [[ -n "$default_branch" ]]; then
		echo "$default_branch"
	else
		# Fallback to master if we cannot determine the default branch
		echo "master"
	fi
}

# Function to install a single plugin
install_plug() {
	local repo="$1"
	local branch="${2:-default}"
	local type="${3:-start}"
	local actual_branch="$branch"

	# Resolve "default" to the actual default branch
	if [[ "$branch" == "default" ]]; then
		echo "Detecting default branch for ${repo}..."
		actual_branch=$(get_default_branch "$repo")
		echo "  Default branch is: ${actual_branch}"
	fi

	local plugin_name
	plugin_name=$(basename "$repo" .git)
	local plugin_path="${PACKAGE_DIR}/${type}/${plugin_name}"

	echo "Installing ${plugin_name} (${type}) from branch ${actual_branch}..."

	if [[ -d "$plugin_path" ]]; then
		echo "  Plugin ${plugin_name} already exists, skipping..."
		return
	fi

	if git clone --branch="$actual_branch" --recurse-submodules --shallow-submodules "https://${repo}.git" "$plugin_path"; then
		echo "  Successfully installed ${plugin_name}"
		# Show submodule info if present (for user information only)
		if [[ -f "$plugin_path/.gitmodules" ]]; then
			local submodule_count
			submodule_count=$(cd "$plugin_path" && git submodule status | wc -l)
			echo "  Found ${submodule_count} submodules"
		fi
	else
		echo "  Failed to install ${plugin_name}"
		return 1
	fi
}

# Function to update a single plugin
update_plug() {
	local plugin_path="$1"
	local plugin_name
	plugin_name=$(basename "$plugin_path")

	echo "Updating ${plugin_name}..."

	if cd "$plugin_path"; then
		# Get repository info
		local repo_url branch_from_lock
		repo_url=$(git config --get remote.origin.url | sed 's|https://||' | sed 's|\.git$||')

		# Find the branch from lock file
		if [[ -f "$LOCK_FILE" ]]; then
			branch_from_lock=$(grep "^${repo_url}:" "$LOCK_FILE" | cut -d':' -f2)
		fi

		# If we can't find branch in lock file, try to detect current branch or use default
		if [[ -z "$branch_from_lock" ]]; then
			branch_from_lock=$(git branch --show-current 2>/dev/null || echo "")
			if [[ -z "$branch_from_lock" ]]; then
				# We're in detached HEAD, get the default branch
				branch_from_lock=$(get_default_branch "$repo_url")
				echo "  Plugin is in detached HEAD state, using default branch: ${branch_from_lock}"
			fi
		fi

		# Fetch the latest changes
		if git fetch origin "$branch_from_lock"; then
			# Check if we're in detached HEAD state
			local current_branch
			current_branch=$(git branch --show-current 2>/dev/null || echo "")

			if [[ -z "$current_branch" ]]; then
				echo "  Checking out branch ${branch_from_lock}..."
				git checkout -B "$branch_from_lock" "origin/${branch_from_lock}"
			fi

			# Now update to the latest commit
			if git pull origin "$branch_from_lock"; then
				# Update submodules if they exist
				if [[ -f ".gitmodules" ]]; then
					echo "  Updating submodules for ${plugin_name}..."
					git submodule update --init --recursive --remote
				fi

				echo "  Successfully updated ${plugin_name}"
				return 0
			else
				echo "  Failed to pull latest changes for ${plugin_name}"
				return 1
			fi
		else
			echo "  Failed to fetch from origin for ${plugin_name}"
			return 1
		fi
	else
		echo "  Failed to access ${plugin_name} directory"
		return 1
	fi
}

# Function to freeze a plugin's state into the lock file
freeze_plugin() {
	local plugin_path="$1"
	local type="$2"
	local output_file="$3"

	local plugin_name
	plugin_name=$(basename "$plugin_path")

	if cd "$plugin_path"; then
		# Get repository URL (remove https:// and .git)
		local repo_url current_commit current_branch
		repo_url=$(git config --get remote.origin.url | sed 's|https://||' | sed 's|\.git$||')
		current_commit=$(git rev-parse HEAD)

		# Try to get current branch name
		current_branch=$(git branch --show-current 2>/dev/null || echo "")

		# If we're in detached HEAD, try to find which branch contains this commit
		if [[ -z "$current_branch" ]]; then
			echo "  ${plugin_name}: In detached HEAD state, finding branch..."

			# Get all remote branches that contain this commit
			local containing_branches
			containing_branches=$(git branch -r --contains "$current_commit" 2>/dev/null | sed 's/origin\///' | grep -v 'HEAD' | head -1 | xargs)

			if [[ -n "$containing_branches" ]]; then
				current_branch="$containing_branches"
				echo "    Found commit in branch: ${current_branch}"
			else
				# Fallback to default branch
				current_branch=$(get_default_branch "$repo_url")
				echo "    Using default branch: ${current_branch}"
			fi
		fi

		# Check if working directory is clean
		local status_info=""
		if ! git diff-index --quiet HEAD 2>/dev/null; then
			status_info=" (DIRTY - has uncommitted changes)"
		fi

		echo "  ${plugin_name} (${type}): ${current_commit:0:8} on ${current_branch}${status_info}"

		# Write to lock file
		echo "${repo_url}:${current_branch}:${current_commit}:${type}" >>"$output_file"

		return 0
	else
		echo "  Failed to access ${plugin_name} directory"
		return 1
	fi
}

install() {
	echo "Installing plugins..."

	# NOTE: Install plugins here
	install_plug "github.com/nvim-treesitter/nvim-treesitter" "master" "start"
	install_plug "github.com/neovim/nvim-lspconfig" "default" "start"
	install_plug "github.com/sainnhe/everforest" "default" "start"
	install_plug "github.com/tpope/vim-sleuth" "default" "start"
	install_plug "github.com/stevearc/conform.nvim" "default" "start"
	install_plug "github.com/echasnovski/mini.nvim" "default" "start"
	install_plug "github.com/rafamadriz/friendly-snippets" "default" "opt"
	install_plug "github.com/folke/lazydev.nvim" "default" "opt"
	install_plug "github.com/github/copilot.vim" "default" "start"
	install_plug "github.com/luukvbaal/statuscol.nvim" "default" "start"
	echo "Plugin installation complete!"

	# Create lock file (but don't fail if no plugins to freeze)
	if ! freeze 2>/dev/null; then
		echo "Note: Lock file creation skipped (no plugins found)"
	fi
}

update() {
	echo "Updating plugins..."

	local updated_count=0

	# Update all plugins in start directory
	if [[ -d "${PACKAGE_DIR}/start" ]]; then
		for plugin_path in "${PACKAGE_DIR}/start"/*; do
			if [[ -d "$plugin_path/.git" ]]; then
				if update_plug "$plugin_path"; then
					((updated_count++))
				fi
			fi
		done
	fi

	# Update all plugins in opt directory
	if [[ -d "${PACKAGE_DIR}/opt" ]]; then
		for plugin_path in "${PACKAGE_DIR}/opt"/*; do
			if [[ -d "$plugin_path/.git" ]]; then
				if update_plug "$plugin_path"; then
					((updated_count++))
				fi
			fi
		done
	fi

	echo "Updated ${updated_count} plugins!"
	# Update lock file (but don't fail if no plugins to freeze)
	if ! freeze 2>/dev/null; then
		echo "Note: Lock file creation skipped (no plugins found)"
	fi
}

restore() {
	if [[ -f "$LOCK_FILE" ]]; then
		echo "Restoring plugins from lock file: ${LOCK_FILE}"

		# Remove existing plugins
		rm -rf "${PACKAGE_DIR}/start"/* "${PACKAGE_DIR}/opt"/* 2>/dev/null || true

		# Read lock file and restore each plugin
		while IFS=':' read -r repo branch commit_hash type; do
			[[ -z "$repo" ]] && continue # Skip empty lines

			local plugin_name
			plugin_name=$(basename "$repo" .git)
			local plugin_path="${PACKAGE_DIR}/${type}/${plugin_name}"

			echo "Restoring ${plugin_name} at commit ${commit_hash:0:8} (${type}) from branch ${branch}..."

			if git clone --recurse-submodules "https://${repo}.git" "$plugin_path"; then
				if cd "$plugin_path" && git checkout "$commit_hash"; then
					# Update submodules to the exact state recorded in this commit
					# No need to specify individual submodule commits - git knows them
					if [[ -f ".gitmodules" ]]; then
						echo "  Restoring submodules for ${plugin_name}..."
						git submodule update --init --recursive
					fi

					echo "  Successfully restored ${plugin_name}"
				else
					echo "  Failed to checkout commit ${commit_hash} for ${plugin_name}"
				fi
			else
				echo "  Failed to clone ${plugin_name}"
			fi
		done <"$LOCK_FILE"

		echo "Plugin restoration complete!"
	else
		echo "Lock file not found at ${LOCK_FILE}"
		echo "Run '$0 install' or '$0 freeze' first to create the lock file."
		exit 1
	fi
}

freeze() {
	echo "Freezing current plugin state..."

	local frozen_count=0
	local temp_lock="${LOCK_FILE}.tmp"

	# Initialize temporary lock file
	>"$temp_lock"

	# Process plugins in start directory
	if [[ -d "${PACKAGE_DIR}/start" ]]; then
		for plugin_path in "${PACKAGE_DIR}/start"/*; do
			if [[ -d "$plugin_path/.git" ]]; then
				if freeze_plugin "$plugin_path" "start" "$temp_lock"; then
					((frozen_count++))
				fi
			fi
		done
	fi

	# Process plugins in opt directory
	if [[ -d "${PACKAGE_DIR}/opt" ]]; then
		for plugin_path in "${PACKAGE_DIR}/opt"/*; do
			if [[ -d "$plugin_path/.git" ]]; then
				if freeze_plugin "$plugin_path" "opt" "$temp_lock"; then
					((frozen_count++))
				fi
			fi
		done
	fi

	# Replace lock file with new frozen state
	if [[ -s "$temp_lock" ]]; then
		mv "$temp_lock" "$LOCK_FILE"
		echo "Successfully froze ${frozen_count} plugins!"
		echo "Lock file updated at: ${LOCK_FILE}"
	else
		rm -f "$temp_lock"
		echo "No plugins found to freeze."
		exit 1
	fi
}

clear() {
	echo "Clearing all plugins..."
	rm -rf "${PACKAGE_DIR}/start"/* "${PACKAGE_DIR}/opt"/* 2>/dev/null || true
	echo "All plugins cleared!"
}

# Show usage if no arguments provided
if [[ $# -eq 0 ]]; then
	echo "Usage: $0 {install|update|restore|freeze|clear}"
	echo ""
	echo "Commands:"
	echo "  install   Install plugins and create lock file"
	echo "  update    Update all installed plugins and submodules"
	echo "  restore   Restore plugins from lock file to exact versions"
	echo "  freeze    Save current plugin state to lock file"
	echo "  clear     Remove all plugins"
	echo ""
	echo "Branch options:"
	echo "  default   Use the repository's default branch (recommended)"
	echo "  main      Use the 'main' branch specifically"
	echo "  master    Use the 'master' branch specifically"
	echo "  <branch>  Use any specific branch name"
	echo ""
	echo "Lock file location: ${LOCK_FILE}"
	echo "Lock file format: repo:branch:commit_hash:type"
	exit 1
fi

case "$1" in
install)
	install
	;;
update)
	update
	;;
restore)
	restore
	;;
freeze)
	freeze
	;;
clear)
	clear
	;;
*)
	echo "Usage: $0 {install|update|restore|freeze|clear}"
	exit 1
	;;
esac
