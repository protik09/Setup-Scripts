#!/usr/bin/env bash

quitprogram()
{
    echo ; echo "Exiting Program..."; echo
    exit 0
}

# Check if this script has been run before by checking for a surreptious file you leave behind in Documents
if [ -e ti_fsw_setup_end.token ]
then
    echo "This script has run to completion once. Please do not run again."
    quitprogram
elif [ -e ti_fsw_setup_middle.token ]
then
    echo "This script was aborted in the middle of execution previously. Please contact Protik Banerji <protik.banerji@teamindus.in> and do not run it."
    echo
    quitprogram
else
    echo "This is the first time this script has run."
fi

# First things first we need to get Git, it'll be used to get the rest of the setup scripts.
sudo apt install -y git

# Now let's get the username for your git repos.
echo "Please Enter your git username:"
read gitusername
echo "Please Enter you First Name and Last Name:"
read gituser
echo "Please enter your teamindus email in full:"
read gitemail

# Properly setup the git infrastructure
echo; echo "Setting up your git environment."
git config --global user.name $gituser
git config --global  user.email $gitemail

# Since the program has started add the in midrun token to the documents folder.
touch ~/Documents/ti_fsw_setup_middle.token

# Commented out the follwoing as manual intervention is necessary.
#echo "Removing the need to type annoying sudo passwords. (Warning this reduces security if you leave your desktpo unlocked)."
#if [ ! -z "$1" ]; then
#    echo $USER "ALL=(ALL) NOPASSWD: ALL" >> $1
#else
#    export EDITOR=$0
#    sudo visudo
#fi
# sudo echo $USER 'ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Then we go to the home directory and make a nice Projects folder for all out git repos
cd ~
mkdir Projects > /dev/null 2>&1 || true # This is so that it keeps running even if the Projects foder exists.
cd Projects
git clone https://www.github.com/protik09/Setup-Scripts.git
git clone $gitusername@10.10.0.26:/axiom/flight-software/depot/LanderFlightSoftware.git

# First we go into LanderFlightSoftware and install all the dependencies for building stuff, then we'll install the fun stuff.
echo "Downloading LanderFlightSoftware and install it's respective dependencies."
cd LanderFlightSoftware
git checkout development
cd install
/bin/bash install_all.sh


# Now that the important stuff in installed we'll install the python dependencies
cd ~/Projects/Setup-Scripts/python_install_scripts
/bin/bash sudo -H python_dependencies.sh

# Furthermore we shall install GUI stuff for fun & profit!!
cd ~/Projects/Setup-Scripts/
sudo chmod a+x *.sh
/bin/bash linux_tools_n_themes.sh

# Now that the text editors have been installed, let's instal all those useful plugins that we know and love.
cd ~/Projects/Setup-Scripts/text_editor_scripts
/bin/bash vs-code_plugins_setup.sh

# Remove midrun token and write the end of run token to the Documents folder
rm ~/Documents/ti_fsw_setup_middle.token
touch ti_fsw_setup_end.token
