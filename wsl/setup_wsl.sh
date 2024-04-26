#! /bin/bash

# Add manual skips if a command fails in the following script
set -e

# Update apt and full and autoremove
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y

# Install dependencies for pyenv
sudo apt-get install -y make git build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl \
cmake ninja-build pkg-config libclang-dev gcc g++ clang tar bzip2 vim \
libopenblas-dev llvm-14 tree nala python3-pip ncdu

# Install python packages
# Check bashrc to see if /home/raspberry/.local/bin already exists
if grep -q "$HOME/.local/bin" ~/.bashrc; then
    echo "$HOME/.local/bin already in bashrc"
else
    # Add /home/raspberry/.local/bin to bashrc
    cat <<EOF >> ~/.bashrc
# Add $HOME/.local/bin to PATH
export PATH="\$HOME/.local/bin:\$PATH"
EOF
fi
source "$HOME/.bashrc"

# Use a loop to install Python packages
export LLVM_CONFIG=llvm-config-14 # This env var is to fix issues with installs of llvmlite and numba
python_packages=(pip setuptools wheel ipython jupyterlab numpy pandas matplotlib seaborn coloredlogs numba uv)

# Get the Python version
python_version=$(python3 --version | cut -d " " -f 2 | cut -d "." -f 1-2)

for package in "${python_packages[@]}"; do
    # Check the Python version
    if (( $(echo "$python_version > 3.10" | bc -l) )); then
        # If the Python version is less than 3.8, include the --break-system-packages flag
        pip3 install --upgrade "$package" --break-system-packages
    else
        # If the Python version is 3.8 or greater, skip the --break-system-packages flag
        pip3 install --upgrade "$package"
    fi
done
# Check bashrc to see if gitprompt.sh is already there
if grep -q "gitprompt.sh" ~/.bashrc; then
    echo "gitprompt.sh already in bashrc"
else
    # Install magic monty git bash
    git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
    cat <<EOF >> ~/.bashrc
# Add stuff for the Magic Monty Bash Git Prompt
if [ -f "\$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source "\$HOME/.bash-git-prompt/gitprompt.sh"
fi
# End Magic Monty Bash Git Prompt
EOF
fi
source "$HOME/.bashrc"

# Install btop
# Check if btop exists else install
if command -v btop &> /dev/null; then
    echo "btop already installed"
else
    # Get the latest tbz from github
    wget -q --secure-protocol=TLSv1_2 --check-certificate https://github.com/aristocratos/btop/releases/latest/download/btop-x86_64-linux-musl.tbz

    # Extract the tbz using tar
    tar -xjf btop-x86_64-linux-musl.tbz

    # Follow install instruction from https://github.com/aristocratos/btop
    pushd btop
    sudo make install
    sudo make setuid
    popd
    # Remove the tbz and the extracted folder
    rm btop-x86_64-linux-musl.tbz

    rm -rf btop
fi

# Install rust
# Check if rust exists else install
if command -v rustc &> /dev/null; then
    echo "rust already installed"
else
    curl --proto '=https' --tlsv1.2 -sSfL https://sh.rustup.rs | sh -s -- -y
fi

# Install ollama
# Check if ollama exists else install
# if command -v ollama &> /dev/null; then
#     echo "ollama already installed"
# else
#     curl --proto '=https' --tlsv1.2 -fsSL https://ollama.com/install.sh | sh
# fi

# Add bash aliases
# Define the path to the bash_aliases file
file="$HOME/.bash_aliases"

# Check if the file exists
if [ ! -f "$file" ]; then
    # If the file doesn't exist, create it
    touch "$file"
    echo "bash_aliases file created."
else
    # If the file exists, do nothing
    echo "bash_aliases file already exists."
fi
# Check to see if alias already in bash_aliases
# Use a loop to add aliases to ~/.bash_aliases
aliases=(
    "ll='ls -l'"
    "la='ls -la'"
    "updateall='sudo nala update; sudo nala upgrade --full -y; sudo apt autoremove -y; rustup update; cargo install-update -a'"
    "udpateall='updateall'"
    "python='python3'"
    "pip='pip3'"
    "pyenv='~/.pyenv/bin/pyenv'"
    "htop='btop'"
    "du='ncdu --color dark -rr -x --exclude .git'"
)
for alias_def in "${aliases[@]}"; do
    if ! grep -q "$alias_def" ~/.bash_aliases; then
        echo "alias $alias_def" >> ~/.bash_aliases
    fi
done
source "$HOME/.bashrc"
