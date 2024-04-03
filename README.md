# Setup-Scripts

![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white) ![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-%234D4D4D.svg?style=for-the-badge&logo=windows-terminal&logoColor=white)

This repo contains all the automated setup scripts I wrote to setup my dev environments.
Both for Windows and Linux.

It also includes scripts for autoupdating git folders.

*Note:* Please note that *some* of the *.bat* scripts, require <a href="https://msdn.microsoft.com/en-us/commandline/wsl/install-win10">Windows Subsystem For Linux</a> running on a PC with a 64-bit version of Windows 10 Anniversary Update or later (build 1607+).

## Setup Raspberry Pi

![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white) ![Raspberry Pi](https://img.shields.io/badge/-RaspberryPi-C51A4A?style=for-the-badge&logo=Raspberry-Pi)

Run the following command to setup the raspberry pi 1

```bash
wget -O - https://github.com/protik09/Setup-Scripts/raw/master/raspberrypi/raspi.sh | bash
```

Run the following command to setup the most common rust programs

```bash
wget -O - https://github.com/protik09/Setup-Scripts/raw/master/raspberrypi/raspi_cargo.sh | bash
```
