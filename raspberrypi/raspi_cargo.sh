#!/usr/bin/env bash

# Add manual skips if a command fails in the following script
set -e

# Install rust apps
# Check if tealdeer already exists in rustup
if ! command -v tldr &> /dev/null; then
    echo "Installing tealdeer"
    cargo install tealdeer
fi
# Check if just app already exists
if ! command -v just &> /dev/null; then
    echo "Installing just"
    cargo install just
fi
