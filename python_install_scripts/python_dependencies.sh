#!/usr/bin/env bash
#
# Script to setup the IMU and SSU simulator dependencies.
#
# Author - Protik Banerji <protik.banerji@teamindus.in>
#
# Add "skip" as a command line argument to skip git cloning and OS updates

# SPECIFY COLORS TO BE USED IN LINUX TERMINAL
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
LIGHTCYAN='\033[1;36m'
NC='\033[0m' # No Color

# Write ALL THE FUNCTIONS!!! \-O-/

sudocheck()
{
	if (( $EUID != 0 )); then  # if not running as root; then
		echo
		echo "Please run as root. See below for proper syntax:"; echo
		echo -e "${RED}sudo -H $0 ${NC}"
		echo
		echo "If you want to skip git clone and OS updates please see below for proper syntax."; echo
		echo -e "${GREEN}sudo -H $0 skip ${NC}"
		quitprogram
	else
		oscheck
	fi
}
 
oscheck()
{
	OS=$(lsb_release -si)
	echo ; echo "OS Version is $OS"; echo
	if [ "$OS" = "Ubuntu" ]; then
		echo "You're running this program on $OS."
		if [ "$arg1" = "skip" ]; then
			echo; echo "You have chosen to skip the full script and only install the python pip dependencies"; echo
			commondepends
		else
			echo; echo "Your're running the full version of the script. All dependencies will be installed"; echo
			ubuntudepends
		fi
	elif [ "$OS" = "wrlinux-small" ]; then
		echo "You're running this program on the Zedboard."
		if [ "$arg1" = "skip" ]; then
			echo; echo "You have chosen to skip the full script and only install the python pip dependencies"; echo
			commondepends
		else
			echo; echo "Your're running the full version of the script. All dependencies will be installed"; echo
			zedboarddepends
		fi
	else
		echo "I don't understand what OS you're running, I'll exit just in case."; quitprogram
	fi
}


ubuntudepends()
{
	sudo apt update
	sudo apt full-upgrade
	sudo apt install -y python-pip git
	sudo apt install python-tk
	sudo apt install python3-pip
	# gitclone # NOt required since you're not using the sysfs-gpio in Ubuntu
	commondepends
	sudo apt autoremove
}

zedboarddepends()
{
	smart update
	smart upgrade
	smart install python-pip
	gitclone
	commondepends

}

gitclone()
{
	git clone https://github.com/derekstavis/python-sysfs-gpio.git
	cd python-sysfs-gpio
	python setup.py install
}

commondepends()
{
  	# cd ..
	# pip2 install --upgrade setuptools
	# pip2 install --upgrade python-build
	# pip2 install --upgrade pytools python-periphery
	# pip2 install --upgrade xlrd pyexcel pyexcel-xls pyexcel-xlsx
	# echo "Installing numpy will take an hour or more. Please be patient."; sleep 5
	# pip2 install --upgrade numpy
	# pip2 install --upgrade scipy
	# pip2 install --upgrade pandas
	# pip2 install --upgrade cronus
	# pip2 install --upgrade pyserial
	# pip2 install --upgrade pdb
	# pip2 install --upgrade xlsxwriter
	# pip2 install --upgrade termcolor
	# pip2 install --upgrade colorama
	# pip2 install --upgrade pyfiglet
	# pip2 install --upgrade pycrc
	# pip2 install --upgrade twisted service_identity
	# pip2 install --upgrade pydoctor epydoc
	pip install --upgrade --requirement python_requirements.txt
	#pip3 install --upgrade --requirement python_requirements.txt
}

quitprogram()
{
	echo ; echo "Exiting Program..."; echo
	exit 0
}


# Run functions in sequence
arg1="$1"
sudocheck
quitprogram
