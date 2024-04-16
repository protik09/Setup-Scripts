#!/usr/bin/env bash

# First let's add all the new repositories to the list

echo "Adding the Themes Repositories to the list..."

echo "Now we'll add some useful widget and tool repositories...."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - # Add chrome keys
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' # Add chrome repo

echo "Lets add the nice text editor repositories...."
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' # vscode keys and repo address

echo "Let's get updates and install all this stuff..."
sudo apt update
sudo apt -y full-upgrade

# Install Themes

echo "Installing Themes...."
echo "NO THEMES"
# sudo apt remove unity-tweak-tool && sudo apt install -y gnome-tweak-tool

# Install Tools

echo "Installing Tools...."
sudo apt install -y wget
sudo apt install -y git
sudo apt install -y clang
sudo apt install -y openssh-server
sudo apt install -y openssh
# sudo apt install -y variety variety-slideshow
# sudo apt install -y indicator-multiload
sudo apt install -y python-pip
sudo apt install -y google-chrome-stable
sudo apt install -y code
sudo apt install -y xrdp

# Delete useless programs
sudo apt-get remove --purge libreoffice*
sudo apt-get clean
sudo apt-get autoremove
sudo apt autoremove -y

echo "Downloading Manual Install Packages"
echo "Installing WPS Office"
echo "NO WPS!!!"
# wget -O ~/Downloads/wps-office_a21.deb http://kdl1.cache.wps.com/ksodl/download/linux/a21//wps-office_10.1.0.5707~a21_amd64.deb #change this if it ever updates
# sudo dpkg -i ~/Downloads/wps-office_*.deb
# sudo apt install -f # Install any missing dependencies.
