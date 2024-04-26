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

# Install cargo-update to keep all the global rust programs up to date
if ! command -v "cargo-install-update" &> /dev/null; then
    echo "Installing cargo-update"
    cargo binstall cargo-update -y
else
    echo "Cargo-update already installed."
fi

# Check if bat already exists
if ! command -v bat &> /dev/null; then
    echo "Installing bat (cat with syntax highlighting)"
    cargo binstall bat -y
    # Replace cat with bat
    aliases=(
    "cat='\bat'"
    "dcat='\cat'"
    )
    for alias_def in "${aliases[@]}"; do
        if ! grep -q "$alias_def" ~/.bash_aliases; then
            echo "alias $alias_def" >> ~/.bash_aliases
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

## Convenient generic rust program install script
install_tool() {
    local program_name="$1"
    if ! command -v "$program_name" &> /dev/null; then
        echo "Installing $program_name..."
        cargo binstall "$program_name" -y
    else
        echo "$program_name already installed."
    fi
}
# Put your rust program names HERE!!
#NOTHING Yet. They all have custom install scripts






# Add the fuzzy file checker fzf to zoxide
fzf_install() {
    # Get current architecture
    arch=$(uname -m)
    if [ "$arch" = "x86_64" ]; then
        arch="amd64"
    elif [ "$arch" = "aarch64" ]; then
        arch="arm64"
    elif [ "$arch" = "armv5l" ]; then
        arch="armv5"
    elif [ "$arch" = "armv6l" ]; then
        arch="armv6"
    elif [ "$arch" = "armv7l" ]; then
        arch="armv7"
    fi
    # echo "Architecture detected as: $arch"

    # Construct download URL for the latest release
    download_url="https://github.com/junegunn/fzf/releases/download/${latest_release_tag}/fzf-${latest_release_tag}-linux_${arch}.tar.gz"

    # Download the latest fzf release
    echo "Downloading fzf ${latest_release_tag}... from $download_url"
    wget -q "$download_url" -O fzf.tar.gz

    # Extract the downloaded archive
    echo "Extracting fzf..."
    tar -xf fzf.tar.gz

    # Move the fzf binary to the local bin folder
    echo "Moving fzf to ~/.local/bin..."
    mv fzf ~/.local/bin
    # sudo mv fzf /usr/local/bin/

    # Clean up temporary files
    echo "Cleaning up..."
    rm fzf.tar.gz

    echo "fzf ${latest_release_tag} installed successfully!"

    # Check if eval "$(fzf --bash)" exists in bashrc
    if ! grep -q 'eval "$(fzf --bash)"' ~/.bashrc &> /dev/null; then
        echo "Adding fzf to bashrc..."
        cat <<EOF >> ~/.bashrc
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
EOF
    fi
}
# Check for latest fzf release
latest_release_url="https://api.github.com/repos/junegunn/fzf/releases/latest"
latest_release_data=$(curl -s "$latest_release_url")

# Extract the latest release tag using grep and cut
latest_release_tag=$(echo "$latest_release_data" | grep '"tag_name":' | cut -d'"' -f4)

# Check if fzf is already installed
if ! command -v fzf &> /dev/null; then
    fzf_install
else
    current_version=$(fzf --version | cut -d' ' -f1)
    echo "fzf $current_version already installed."
fi

# Compare versions
if [[ "$current_version" < "$latest_release_tag" ]]; then
    echo "fzf $current_version is outdated. Installing the latest version $latest_release_tag..."
    fzf_install
fi


### ADD ANY MORE INSTALL STUFF ABOVE THIS LINE!!! THIS CHUNK NEEDS TO BE AT THE BOTTOM OF THIS FILE!
# Check if zoxide change directory module already exists
if ! grep -q 'zoxide init' ~/.bashrc &> /dev/null; then
    echo "Installing Zoxide"
    cargo binstall zoxide -y
    cat <<EOF >> ~/.bashrc
# Zoxide better CD (THIS ALWAYS NEEDS TO BE AT THE BOTTOM OF BASHRC!!)
eval "$(zoxide init --cmd cd bash)"
EOF
else
    echo "Zoxide already installed."
fi
