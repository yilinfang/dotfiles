#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
# Use 'bash' to ensure compatibility with features like 'sed -E'.
set -e

# --- Configuration with Environment Variables and Defaults ---

# Use INSTALL_DIR from environment or default to ~/.local/bin
INSTALL_DIR="${INSTALL_DIR:-${HOME}/.local/bin}"
# Use CHEZMOI_VERSION from environment or default to 'latest'
CHEZMOI_VERSION_SPEC="${CHEZMOI_VERSION:-latest}"
# Use MISE_VERSION from environment or default to 'latest'
MISE_VERSION_SPEC="${MISE_VERSION:-latest}"

echo "--- Configuration ---"
echo "Installation Directory: ${INSTALL_DIR}"
echo "chezmoi Version Spec:   ${CHEZMOI_VERSION_SPEC}"
echo "mise Version Spec:      ${MISE_VERSION_SPEC}"
echo "---------------------"

# --- Version Resolution ---

# Resolve 'latest' for chezmoi by querying the GitHub API
if [ "${CHEZMOI_VERSION_SPEC}" = "latest" ]; then
  echo "Querying GitHub API for the latest chezmoi version..."
  CHEZMOI_VERSION=$(curl -sSL "https://api.github.com/repos/twpayne/chezmoi/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
  if [ -z "$CHEZMOI_VERSION" ]; then
    echo "Error: Could not determine latest chezmoi version. GitHub API limit may have been reached." >&2
    exit 1
  fi
else
  CHEZMOI_VERSION="${CHEZMOI_VERSION_SPEC}"
fi

# Resolve 'latest' for mise by querying the GitHub API
if [ "${MISE_VERSION_SPEC}" = "latest" ]; then
  echo "Querying GitHub API for the latest mise version..."
  MISE_VERSION=$(curl -sSL "https://api.github.com/repos/jdx/mise/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
  if [ -z "$MISE_VERSION" ]; then
    echo "Error: Could not determine latest mise version. GitHub API limit may have been reached." >&2
    exit 1
  fi
else
  MISE_VERSION="${MISE_VERSION_SPEC}"
fi

echo
echo "--- Installation Plan ---"
echo "Installing chezmoi version: ${CHEZMOI_VERSION}"
echo "Installing mise version:    ${MISE_VERSION}"
echo "-------------------------"
echo

# --- Setup ---
mkdir -p "${INSTALL_DIR}"

# --- Platform Detection ---
case "$(uname -s)" in
Linux)
  CHEZMOI_OS='linux'
  MISE_OS='linux'
  ;;
Darwin)
  CHEZMOI_OS='darwin'
  MISE_OS='macos'
  ;;
*)
  echo "Unsupported OS: $(uname -s)" >&2
  exit 1
  ;;
esac

case "$(uname -m)" in
x86_64)
  CHEZMOI_ARCH='amd64'
  MISE_ARCH='x64'
  ;;
arm64 | aarch64)
  CHEZMOI_ARCH='arm64'
  MISE_ARCH='arm64'
  ;;
*)
  echo "Unsupported architecture: $(uname -m)" >&2
  exit 1
  ;;
esac

# --- Installation Process ---
TMP_DIR=$(mktemp -d)
trap 'rm -rf -- "$TMP_DIR"' EXIT
cd "${TMP_DIR}"

# --- Install chezmoi ---
echo "Downloading chezmoi v${CHEZMOI_VERSION}..."
CHEZMOI_FILENAME="chezmoi_${CHEZMOI_VERSION}_${CHEZMOI_OS}_${CHEZMOI_ARCH}.tar.gz"
CHEZMOI_URL="https://github.com/twpayne/chezmoi/releases/download/v${CHEZMOI_VERSION}/${CHEZMOI_FILENAME}"

curl -fsSL -o "${CHEZMOI_FILENAME}" "${CHEZMOI_URL}"
echo "Extracting and locating chezmoi binary..."
tar -xzf "${CHEZMOI_FILENAME}"

# Use find to locate the binary robustly, regardless of directory structure.
CHEZMOI_PATH=$(find . -type f -name chezmoi)
if [ ! -f "$CHEZMOI_PATH" ]; then
  echo "Error: Could not find 'chezmoi' binary in the downloaded archive." >&2
  exit 1
fi

mv "$CHEZMOI_PATH" "${INSTALL_DIR}/chezmoi"
chmod +x "${INSTALL_DIR}/chezmoi"
echo "chezmoi v${CHEZMOI_VERSION} installed successfully."
echo

# --- Install mise ---
echo "Downloading mise v${MISE_VERSION}..."
MISE_FILENAME="mise-v${MISE_VERSION}-${MISE_OS}-${MISE_ARCH}.tar.gz"
MISE_URL="https://github.com/jdx/mise/releases/download/v${MISE_VERSION}/${MISE_FILENAME}"

curl -fsSL -o "${MISE_FILENAME}" "${MISE_URL}"
echo "Extracting and locating mise binary..."
tar -xzf "${MISE_FILENAME}"

# Use find to locate the binary robustly.
MISE_PATH=$(find . -type f -name mise)
if [ ! -f "$MISE_PATH" ]; then
  echo "Error: Could not find 'mise' binary in the downloaded archive." >&2
  exit 1
fi

mv "$MISE_PATH" "${INSTALL_DIR}/mise"
chmod +x "${INSTALL_DIR}/mise"
echo "mise v${MISE_VERSION} installed successfully."
echo

# --- Verification and Final Instructions ---
echo "Verifying installations..."
"${INSTALL_DIR}/chezmoi" --version
"${INSTALL_DIR}/mise" --version
echo
echo "Installation complete."
echo "Ensure '${INSTALL_DIR}' is in your PATH."
