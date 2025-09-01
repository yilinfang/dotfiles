#!/usr/bin/env bash
# Used for managing secrets from GitHub gist

set -euo pipefail

# Configuration
GITHUB_USERNAME="yilinfang"
GITHUB_GIST_ID="d80fcaba9dbfd299a3f790ff62ea0715"

# File configuration table
# Format: "local_path:gist_filename"
declare -a FILES_CONFIG=(
	"$HOME/.config/github-copilot/apps.json:apps.json.age"
)

# Check dependencies for download operations
check_download_dependencies() {
	local missing_deps=()

	if ! command -v age &>/dev/null; then
		missing_deps+=("age")
	fi

	if ! command -v curl &>/dev/null; then
		missing_deps+=("curl")
	fi

	if [ ${#missing_deps[@]} -ne 0 ]; then
		echo "Missing dependencies for download: ${missing_deps[*]}"
		echo "Please install them first."
		exit 1
	fi
}

# Check dependencies for upload operations
check_upload_dependencies() {
	local missing_deps=()

	if ! command -v age &>/dev/null; then
		missing_deps+=("age")
	fi

	if ! command -v gh &>/dev/null; then
		missing_deps+=("gh (GitHub CLI)")
	fi

	if [ ${#missing_deps[@]} -ne 0 ]; then
		echo "Missing dependencies for upload: ${missing_deps[*]}"
		echo "Please install them first."
		exit 1
	fi
}

# Check dependencies for list operations (minimal)
check_list_dependencies() {
	# List operation only needs basic shell commands, no external dependencies
	return 0
}

# Parse file configuration entry
parse_config_entry() {
	local config_entry="$1"
	local local_path="${config_entry%:*}"
	local gist_filename="${config_entry#*:}"

	# Expand tilde to home directory
	local_path="${local_path/#\~/$HOME}"

	echo "$local_path" "$gist_filename"
}

# Create directory for a file if it doesn't exist
ensure_file_dir() {
	local file_path="$1"
	local dir_path=$(dirname "$file_path")
	mkdir -p "$dir_path"
}

# Download and decrypt a single file
download_file() {
	local local_path="$1"
	local gist_filename="$2"
	local temp_encrypted_file=$(mktemp)

	echo "Downloading $gist_filename..."

	# Download encrypted file
	if ! curl -fsSL "https://gist.githubusercontent.com/${GITHUB_USERNAME}/${GITHUB_GIST_ID}/raw/${gist_filename}" -o "$temp_encrypted_file"; then
		echo "Failed to download $gist_filename from Gist"
		rm -f "$temp_encrypted_file"
		return 1
	fi

	# Ensure directory exists
	ensure_file_dir "$local_path"

	# Decrypt file
	if ! age -d -o "$local_path" "$temp_encrypted_file"; then
		echo "Failed to decrypt $gist_filename."
		rm -f "$temp_encrypted_file"
		return 1
	fi

	# Remove temporary encrypted file
	rm -f "$temp_encrypted_file"

	echo "Successfully downloaded and decrypted $gist_filename to $local_path"
	return 0
}

# Download and decrypt all configured files
download_secrets() {
	echo "Downloading secrets from GitHub Gist..."
	local failed_count=0

	for config_entry in "${FILES_CONFIG[@]}"; do
		# Skip commented lines
		[[ "$config_entry" =~ ^[[:space:]]*# ]] && continue

		read -r local_path gist_filename <<<"$(parse_config_entry "$config_entry")"

		if ! download_file "$local_path" "$gist_filename"; then
			((failed_count++))
		fi
	done

	if [ $failed_count -eq 0 ]; then
		echo "All files downloaded successfully!"
	else
		echo "Failed to download $failed_count file(s)"
		exit 1
	fi
}

# Encrypt and upload a single file
upload_file() {
	local local_path="$1"
	local gist_filename="$2"
	local temp_encrypted_file=$(mktemp)

	echo "Uploading $local_path as $gist_filename..."

	# Check if local file exists
	if [ ! -f "$local_path" ]; then
		echo "Local file $local_path does not exist, skipping..."
		rm -f "$temp_encrypted_file"
		return 1
	fi

	# Encrypt file
	if ! age -e -a -p -o "$temp_encrypted_file" "$local_path"; then
		echo "Failed to encrypt $local_path."
		rm -f "$temp_encrypted_file"
		return 1
	fi

	# Create a temporary directory for gist operations
	local temp_dir=$(mktemp -d)
	local temp_gist_file="$temp_dir/$gist_filename"

	# Copy encrypted file to temp location with correct name
	cp "$temp_encrypted_file" "$temp_gist_file"

	# Update the gist
	if gh gist edit "$GITHUB_GIST_ID" "$temp_gist_file" -f "$gist_filename"; then
		echo "Successfully uploaded $gist_filename to GitHub Gist"
		local success=0
	else
		echo "Failed to update $gist_filename in GitHub Gist"
		local success=1
	fi

	# Cleanup
	rm -rf "$temp_dir"
	rm -f "$temp_encrypted_file"

	return $success
}

# Encrypt and upload all configured files
upload_secrets() {
	echo "Uploading secrets to GitHub Gist..."

	# Check if GitHub CLI is authenticated
	if ! gh auth status &>/dev/null; then
		echo "GitHub CLI is not authenticated. Please run 'gh auth login' first."
		exit 1
	fi

	local failed_count=0

	for config_entry in "${FILES_CONFIG[@]}"; do
		# Skip commented lines
		[[ "$config_entry" =~ ^[[:space:]]*# ]] && continue

		read -r local_path gist_filename <<<"$(parse_config_entry "$config_entry")"

		if ! upload_file "$local_path" "$gist_filename"; then
			((failed_count++))
		fi
	done

	if [ $failed_count -eq 0 ]; then
		echo "All files uploaded successfully!"
	else
		echo "Failed to upload $failed_count file(s)"
		exit 1
	fi
}

# List all configured files
list_files() {
	echo "Configured files:"
	echo "=================="
	printf "%-50s %-30s %-10s\n" "Local Path" "Gist Filename" "Status"
	printf "%-50s %-30s %-10s\n" "----------" "-------------" "------"

	for config_entry in "${FILES_CONFIG[@]}"; do
		# Skip commented lines
		[[ "$config_entry" =~ ^[[:space:]]*# ]] && continue

		read -r local_path gist_filename <<<"$(parse_config_entry "$config_entry")"

		if [ -f "$local_path" ]; then
			local status="EXISTS"
		else
			local status="MISSING"
		fi

		printf "%-50s %-30s %-10s\n" "$local_path" "$gist_filename" "$status"
	done
}

# Show usage information
show_usage() {
	echo "Usage: $0 {download|upload|list}"
	echo ""
	echo "Commands:"
	echo "  download    Download and decrypt all configured files from GitHub Gist"
	echo "              Requirements: age, curl"
	echo "  upload      Encrypt and upload all configured files to GitHub Gist"
	echo "              Requirements: age, gh (GitHub CLI)"
	echo "  list        List all configured files and their status"
	echo "              Requirements: none"
	echo ""
	echo "Configuration:"
	echo "  GitHub Username: $GITHUB_USERNAME"
	echo "  Gist ID: $GITHUB_GIST_ID"
	echo "  Files: ${#FILES_CONFIG[@]} configured"
}

# Main script logic
main() {
	case "${1:-}" in
	"download")
		check_download_dependencies
		download_secrets
		;;
	"upload")
		check_upload_dependencies
		upload_secrets
		;;
	"list")
		check_list_dependencies
		list_files
		;;
	*)
		show_usage
		exit 1
		;;
	esac
}

main "$@"
