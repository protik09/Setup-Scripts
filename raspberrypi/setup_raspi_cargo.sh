#!/usr/bin/bash

# Add manual skips if a command fails in the following script
set -e

# Install rust apps
# Check if tealdeer already exists in rustup
if ! command -v "cargo-binstall" &> /dev/null; then
    echo "Installing binstall"
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
else
    echo "Binstall already installed."
fi
# Check if tealdeer already exists in rustup
if ! command -v bat &> /dev/null; then
    echo "Installing bat (cat with syntax highlighting)"
    cargo binstall bat -y
    # Replace cat with bat
    aliases=(
    "cat='\bat'"
    "dcat='\cat''"
    )
    for alias_def in "${aliases[@]}"; do
        if ! grep -q "$alias_def" ~/.bash_aliases; then
            echo "$alias_def" >> ~/.bash_aliases
        fi
    done
else
    echo "Bat already installed."
fi
# Check if tealdeer already exists in rustup
if ! command -v tldr &> /dev/null; then
    echo "Installing tealdeer"
    cargo binstall tealdeer -y
else
    echo "Tealdeer already installed."
fi
# Check if just app already exists
if ! command -v just &> /dev/null; then
    echo "Installing just"
    cargo binstall just -y
else
    echo "Just already installed."
fi
