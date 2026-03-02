#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${HOME}/.local/bin"
BIN_NAME="tree-sitter"

mkdir -p "${INSTALL_DIR}"

# Create isolated environment
workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

export CARGO_HOME="${workdir}/cargo"
export RUSTUP_HOME="${workdir}/rustup"
export PATH="${CARGO_HOME}/bin:${PATH}"

echo "Installing isolated Rust toolchain..."
curl https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal --no-modify-path

echo "Installing tree-sitter-cli using locked dependencies..."
CARGO_INSTALL_PKG="tree-sitter-cli${TREE_SITTER_VERSION:+@${TREE_SITTER_VERSION}}"
cargo install --locked "${CARGO_INSTALL_PKG}"

echo "Copying binary to ${INSTALL_DIR}..."
install -m 0755 "${CARGO_HOME}/bin/${BIN_NAME}" "${INSTALL_DIR}/${BIN_NAME}"

echo
echo "Installed to ${INSTALL_DIR}/${BIN_NAME}"
"${INSTALL_DIR}/${BIN_NAME}" --version

echo
echo "Add to PATH if needed:"
echo "export PATH=\"${INSTALL_DIR}:\$PATH\""
