#!/usr/bin/env bash

download_dir = ./Downloads

# First let's add all the new repositories to the list

echo "Adding the Themes Repositories to the list..."
sudo add-apt-repository -y ppa:numix/ppa
sudo apt-add-repository -y ppa:tista/adapta
sudo apt-add-repository -y ppa:system76/pop
sudo add-apt-repository -y ppa:peterlevi/ppa
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/vertex-theme.list"
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list"
sudo add-apt-repository -y ppa:noobslab/themes
sudo add-apt-repository -y ppa:noobslab/icons

echo "Now we'll add some useful widget and tool repositories...."
sudo add-apt-repository -y ppa:atareao/atareao
sudo add-apt-repository -y ppa:alexeftimie/ppa

echo "Let's get updates and install all this stuff..."
sudo apt update
sudo apt -y full-upgrade

# Add proper SSH keys to your

# Install Themes

echo "Installing Themes...."
sudo apt remove unity-tweak-tool && sudo apt install -y gnome-tweak-tool
sudo apt install -y numix-gtk-theme
sudo apt install -y numix-icon-theme numix-icon-theme-circle
sudo apt install -y pop-theme
sudo apt install -y adapta-gtk-theme
sudo apt install -y vertex-theme
sudo apt install -y arc-theme
sudo apt install -y windos-10-themes
sudo apt install -y victory-icon-theme

# Install Tools

echo "Installing Tools...."
sudo apt install -y wget
sudo apt install -y git
sudo apt install -y curl
sudo apt install -y clang
sudo apt install -y openssh-server
sudo apt install -y openssh
sudo apt install -y flake8 autopep8
sudo apt install -y devscripts
sudo apt install -y variety variety-slideshow
sudo apt install -y redshift redshift-gtk
sudo apt install -y indicator-multiload
sudo apt install -y python-pip

echo "Downloading Manual Install Packages"
# atom_down = curl -s https://api.github.com/repos/atom/atom/releases | grep browser_download_url | grep '64[.]deb' | head -n 1 | cut -d '"' -f 4
# wget $atom_down
# wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
# echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
# sudo apt update
# sudo apt install sublime-text
