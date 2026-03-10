#!/usr/bin/env bash
# Script used for building Vim and installing it to $HOME/vim

set -euo pipefail

PREFIX="$HOME/vim"
mkdir -p "$PREFIX"

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

cd "$TMPDIR"
wget "https://www.vim.org/downloads/vim-9.2.tar.bz2"
ARCHIVE=vim-9.2.tar.bz2
tar -xjf "$ARCHIVE"

SRC_DIR="$(tar -tjf "$ARCHIVE" | awk '/\/src\/configure$/ { sub(/\/configure$/, "", $0); print; exit }')"
if [ -z "$SRC_DIR" ]; then
  echo "Could not find src/configure in ${ARCHIVE}" >&2
  exit 1
fi

cd "$SRC_DIR"
./configure \
  --prefix="$PREFIX" \
  --with-features=huge \
  --enable-multibyte \
  --enable-python3interp=yes \
  --enable-cscope
JOBS="$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || printf '1')"
make -j"$JOBS"
make install

# Check if $PREFIX/bin is in PATH
if echo "$PATH" | tr ':' '\n' | grep -qx "$PREFIX/bin"; then
  echo "$PREFIX/bin is already in PATH"
else
  echo "$PREFIX/bin is not in PATH. Add the following to your shell config:"
  echo "export PATH=\"$PREFIX/bin:\$PATH\""
fi
