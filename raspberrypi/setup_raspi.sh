#!/usr/bin/env bash

# Add manual skips if a command fails in the following script
set -e

# Update apt and full and autoremove
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y

# Install dependencies for pyenv
sudo apt-get install -y make git build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl \
cmake ninja-build pkg-config libclang-dev gcc g++ clang tar bzip2 vim \
libopenblas-dev llvm-14 tree ncdu bc software-properties-common \
bash-completion

# Install python build-tools
sudo apt-get install -y python3-pip

# Install python packages
# Check bashrc to see if /home/raspberry/.local/bin already exists
if grep -q "/home/raspberry/.local/bin" ~/.bashrc; then
    echo "/home/raspberry/.local/bin already in bashrc"
else
    # Add /home/raspberry/.local/bin to bashrc
    cat <<EOF >> ~/.bashrc
# Add /home/raspberry/.local/bin to PATH
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
    wget --secure-protocol=TLSv1_2 --check-certificate https://github.com/aristocratos/btop/releases/latest/download/btop-armv5l-linux-musleabi.tbz
    # Extract the tbz using tar
    tar -xjf btop-armv5l-linux-musleabi.tbz
    # Follow install instruction from https://github.com/aristocratos/btop
    pushd btop
    sudo make install
    sudo make setuid
    popd
    # Remove the tbz and the extracted folder
    rm btop-armv5l-linux-musleabi.tbz
    rm -rf btop
fi

# Install apt-fast
# Check if apt-fast exists else install
if command -v apt-fast &> /dev/null; then
    echo "apt-fast already installed"
else
    # Install apt-fast
    sudo add-apt-repository -y ppa:apt-fast/stable
    sudo apt-get update
    sudo apt-get -y install apt-fast
    sudo cp completions/bash/apt-fast /etc/bash_completion.d/ # Enable bash completion
    sudo chown root:root /usr/share/zsh/functions/Completion/Debian/_apt-fast
    source /etc/bash_completion
fi

# Install rust
# Check if rust exists else install
if command -v rustc &> /dev/null; then
    echo "rust already installed"
else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# Install pyenv
# Check if pyenv exists else install
if command -v pyenv &> /dev/null; then
    echo "pyenv already installed"
else
    curl https://pyenv.run | bash
    if grep -q "pyenv init" ~/.bashrc; then
        echo "pyenv init already in bashrc"
    else
        cat <<EOF >> ~/.bashrc
# Add pyenv init to bashrc
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF
    fi
fi

# Check if folder Git exists
if [ -d "$HOME/Git" ]; then
    echo "Git folder already exists"
else
    mkdir "$HOME/Git"
fi
pushd "$HOME/Git"
# Check if Setup-Scripts already exists
if [ -d "$HOME/Git/Setup-Scripts" ]; then
    echo "Setup-Scripts already exists"
    pushd "$HOME/Git/Setup-Scripts"
    git pull --rebase
    popd
else
    git clone https://github.com/protik09/Setup-Scripts.git
fi
# Check if MoveLowPriorityListToPrimaryList already exists
if [ -d "$HOME/Git/MoveLowPriorityListToPrimaryList" ]; then
    echo "MoveLowPriorityListToPrimaryList already exists"
    pushd "$HOME/Git/MoveLowPriorityListToPrimaryList"
    git pull --rebase
    popd
else
    git clone https://github.com/protik09/MoveLowPriorityListToPrimaryList.git
fi


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
    "updateall='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y; rustup update; cargo install-update -a'"
    "udpateall='updateall'"
    "python='python3'"
    "pip='pip3'"
    "pyenv='~/.pyenv/bin/pyenv'"
    "du='ncdu --color dark -rr -x --exclude .git --exclude node_modules'" # -rr -x excludes files and folders from the scan
)
for alias_def in "${aliases[@]}"; do
    if ! grep -q "$alias_def" ~/.bash_aliases; then
        echo "alias $alias_def" >> ~/.bash_aliases
    fi
done
source "$HOME/.bashrc"

cd "$HOME/Git/MoveLowPriorityListToPrimaryList"