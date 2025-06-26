#!/usr/bin/env bash

# Install tools with mise

set -euo pipefail # Exit on error, undefined variable, or pipe failure

# Check if mise is installed
if ! command -v mise &>/dev/null; then
  echo "mise is not installed. Please install it first."
  exit 1
fi

# Check if the chezmoi is installed, if not, install it using mise
if ! command -v chezmoi &>/dev/null; then
  mise use -g chezmoi@2.62.7
fi

# Apply the mise configuration
chezmoi apply $HOME/.config/mise

# Install tools using mise
mise install
