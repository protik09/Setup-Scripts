#!/usr/bin/env bash

download_dir = ./Downloads

# First let's add all the new repositories to the list

echo "Adding the Themes Repositories to the list..."

echo "Now we'll add some useful widget and tool repositories...."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - # Add chrome keys
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' # Add chrome repo

echo "Lets add the nice text editor repositories...."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list # Sublime Text 3 keys and repo address
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' # vscode keys and repo address

echo "Let's get updates and install all this stuff..."
sudo apt update
sudo apt -y full-upgrade

# Install Themes

echo "Installing Themes...."
sudo apt remove unity-tweak-tool && sudo apt install -y gnome-tweak-tool

# Install Tools

echo "Installing Tools...."
sudo apt install -y wget
sudo apt install -y git
sudo apt install -y clang
sudo apt install -y html-xml-utils
sudo apt install -y openssh-server
sudo apt install -y openssh
sudo apt install -y flake8 autopep8
sudo apt install -y devscripts
sudo apt install -y variety variety-slideshow
sudo apt install -y redshift redshift-gtk
#sudo apt install -y indicator-multiload
sudo apt install -y python-pip
sudo apt install -y google-chrome-stable
sudo apt install -y sublime-text
sudo apt install -y code gnustep-gui-runtime # Second one allows you to use "say" to test-to-speech in bash
sudo apt install -y xrdp

# Delete useless programs
sudo apt-get remove --purge libreoffice*
sudo apt-get clean
sudo apt-get autoremove
sudo apt autoremove

echo "Downloading Manual Install Packages"
echo "Installing WPS Office"
wget -O ~/Downloads/wps-office_a21.deb http://kdl1.cache.wps.com/ksodl/download/linux/a21//wps-office_10.1.0.5707~a21_amd64.deb #change this if it ever updates
sudo dpkg -i ~/Downloads/wps-office_*.deb
sudo apt install -f # Install any missing dependencies.
