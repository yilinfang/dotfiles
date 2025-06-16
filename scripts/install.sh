#!/usr/bin/env bash

# This script is used to download chezmoi and age.

set -e
# Default versions
DEFAULT_CHEZMOI_VERSION="2.62.6"
DEFAULT_AGE_VERSION="1.2.1"
DEFAULT_TARGET_DIR="$HOME/.chezmoi/bin"

# Initialize variables with custom environment variables or defaults
CHEZMOI_VERSION="${INSTALL_CHEZMOI_VERSION:-$DEFAULT_CHEZMOI_VERSION}"
AGE_VERSION="${INSTALL_AGE_VERSION:-$DEFAULT_AGE_VERSION}"
TARGET_DIR="${INSTALL_TARGET_DIR:-$DEFAULT_TARGET_DIR}"
mkdir -p "$TARGET_DIR" # Ensure target directory exists

# Logging functions
log_info() {
    printf 'info %s\n' "$*" >&2
}

log_error() {
    printf 'error %s\n' "$*" >&2
}

# Check if command exists
is_command() {
    type "$1" >/dev/null 2>&1
}

# Get system architecture
get_arch() {
    arch="$(uname -m)"
    case "$arch" in
    x86_64 | amd64) printf "amd64" ;;
    i386 | i686) printf "386" ;;
    aarch64 | arm64) printf "arm64" ;;
    armv6l) printf "arm" ;;
    armv7l) printf "armv7" ;;
    *)
        log_error "unsupported architecture: $arch"
        exit 1
        ;;
    esac
}

# Get operating system
get_os() {
    os="$(uname -s)"
    case "$os" in
    Linux) printf "linux" ;;
    Darwin) printf "darwin" ;;
    FreeBSD) printf "freebsd" ;;
    OpenBSD) printf "openbsd" ;;
    NetBSD) printf "netbsd" ;;
    CYGWIN* | MINGW* | MSYS*) printf "windows" ;;
    *)
        log_error "unsupported operating system: $os"
        exit 1
        ;;
    esac
}

# Download file with curl or wget
http_download() {
    local_file="$1"
    source_url="$2"

    log_info "downloading $source_url"

    if is_command curl; then
        curl -fsSL -o "$local_file" "$source_url"
    elif is_command wget; then
        wget -q -O "$local_file" "$source_url"
    else
        log_error "neither curl nor wget found"
        exit 1
    fi
}

# Extract archive
extract_archive() {
    archive="$1"
    case "$archive" in
    *.tar.gz | *.tgz)
        tar -xzf "$archive"
        ;;
    *.tar.bz2)
        tar -xjf "$archive"
        ;;
    *.zip)
        unzip -q "$archive"
        ;;
    *)
        log_error "unsupported archive format: $archive"
        exit 1
        ;;
    esac
}

# Get latest release tag from GitHub
get_latest_release() {
    repo="$1"
    if is_command curl; then
        curl -fsSL "https://api.github.com/repos/$repo/releases/latest" |
            grep '"tag_name":' |
            sed -E 's/.*"([^"]+)".*/\1/'
    elif is_command wget; then
        wget -qO- "https://api.github.com/repos/$repo/releases/latest" |
            grep '"tag_name":' |
            sed -E 's/.*"([^"]+)".*/\1/'
    else
        log_error "neither curl nor wget found"
        exit 1
    fi
}

# Get version (either specified or latest)
get_version() {
    repo="$1"
    specified_version="$2"

    if [ "$specified_version" = "latest" ]; then
        get_latest_release "$repo"
    else
        # Add 'v' prefix if not present
        if [[ "$specified_version" != v* ]]; then
            printf "v%s" "$specified_version"
        else
            printf "%s" "$specified_version"
        fi
    fi
}

# Download and install chezmoi
install_chezmoi() {
    log_info "installing chezmoi (version: $CHEZMOI_VERSION)"

    os="$(get_os)"
    arch="$(get_arch)"
    version="$(get_version "twpayne/chezmoi" "$CHEZMOI_VERSION")"

    # Remove 'v' prefix for filename
    version_clean="${version#v}"

    filename="chezmoi_${version_clean}_${os}_${arch}"
    if [ "$os" = "windows" ]; then
        filename="${filename}.zip"
        binary_name="chezmoi.exe"
    else
        filename="${filename}.tar.gz"
        binary_name="chezmoi"
    fi

    url="https://github.com/twpayne/chezmoi/releases/download/${version}/${filename}"

    tmpdir="$(mktemp -d)"
    trap "rm -rf '$tmpdir'" EXIT

    cd "$tmpdir"
    http_download "$filename" "$url"
    extract_archive "$filename"

    # Find and copy the binary
    if [ -f "$binary_name" ]; then
        cp "$binary_name" "$TARGET_DIR/"
    else
        # Sometimes the binary is in a subdirectory
        find . -name "$binary_name" -type f -exec cp {} "$TARGET_DIR/" \;
    fi

    chmod +x "$TARGET_DIR/$binary_name"
    log_info "chezmoi ${version} installed to $TARGET_DIR/$binary_name"
}

# Download and install age
install_age() {
    log_info "installing age (version: $AGE_VERSION)"

    os="$(get_os)"
    arch="$(get_arch)"
    version="$(get_version "FiloSottile/age" "$AGE_VERSION")"

    # Remove 'v' prefix for filename
    version_clean="${version#v}"

    filename="age-v${version_clean}-${os}-${arch}"
    if [ "$os" = "windows" ]; then
        filename="${filename}.zip"
        binary_names="age.exe age-keygen.exe"
    else
        filename="${filename}.tar.gz"
        binary_names="age age-keygen"
    fi

    url="https://github.com/FiloSottile/age/releases/download/${version}/${filename}"

    tmpdir="$(mktemp -d)"
    trap "rm -rf '$tmpdir'" EXIT

    cd "$tmpdir"
    http_download "$filename" "$url"
    extract_archive "$filename"

    # Find and copy the binaries
    for binary_name in $binary_names; do
        if [ -f "$binary_name" ]; then
            cp "$binary_name" "$TARGET_DIR/"
        else
            # Sometimes the binaries are in a subdirectory
            find . -name "$binary_name" -type f -exec cp {} "$TARGET_DIR/" \;
        fi
        chmod +x "$TARGET_DIR/$binary_name"
        log_info "$binary_name installed to $TARGET_DIR/$binary_name"
    done

    log_info "age ${version} installed"
}

# Main execution
main() {
    log_info "detected OS: $(get_os)"
    log_info "detected architecture: $(get_arch)"
    log_info "chezmoi version: $CHEZMOI_VERSION"
    log_info "age version: $AGE_VERSION"

    install_chezmoi
    install_age

    log_info "installation complete"
    log_info "add $TARGET_DIR to your PATH to use chezmoi and age"
    log_info "example: export PATH=\"$TARGET_DIR:\$PATH\""
}

main "$@"
