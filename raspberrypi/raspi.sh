#!/usr/bin/env bash

# Add manual skips if a command fails in the following script
set -e

# Update apt and full and autoremove
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y

# Install dependencies for pyenv
sudo apt-get install -y make git build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl \
cmake ninja-build pkg-config libclang-dev gcc g++ clang

sudo apt install -y vim

# Install python build-tools
sudo apt-get install -y python3-pip python3-pip python3-venv

# Install python packages
pip3 install --upgrade pip
pip3 install --upgrade setuptools
pip3 install --upgrade wheel
pip3 install --upgrade virtualenv
pip3 install --upgrade ipython
pip3 install --upgrade jupyterlab
pip3 install --upgrade numpy
pip3 install --upgrade scipy
pip3 install --upgrade pandas
pip3 install --upgrade matplotlib
pip3 install --upgrade seaborn
pip3 install --upgrade coloredlogs
pip3 install --upgrade numba

# Install magic monty git bash
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
cat <<EOT >> ~/.bashrc
# Add stuff for the Magic Monty Bash Git Prompt
if [ -f "\$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source "\$HOME/.bash-git-prompt/gitprompt.sh"
fi
EOT

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install pyenv
curl https://pyenv.run | bash

# Add bash aliases
echo "alias ll='ls -l'" >> ~/.bash_aliases
echo "alias la='ls -la'" >> ~/.bash_aliases
echo "alias updateall='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'" >> ~/.bash_aliases
echo "alias python='python3'" >> ~/.bash_aliases
echo "alias pip='pip3'" >> ~/.bash_aliases
echo "alias pyenv='~/.pyenv/bin/pyenv'" >> ~/.bash_aliases
