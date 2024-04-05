#!/usr/bin/env bash

# Add manual skips if a command fails in the following script
set -e

# Install rust apps
# Check if tealdeer already exists in rustup
if ! command -v "cargo-binstall" &> /dev/null; then
    echo "Installing binstall"
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
fi
# Check if tealdeer already exists in rustup
if ! command -v tldr &> /dev/null; then
    echo "Installing tealdeer"
    cargo binstall tealdeer
fi
# Check if just app already exists
if ! command -v just &> /dev/null; then
    echo "Installing just"
    cargo binstall just
fi
