## Run the stuff below if the script gives access issues
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
# Set ExecutionPolicy Unrestricted

## Install Powerline. IMPORTANT: Skip if using posh-git
# https://docs.microsoft.com/en-us/windows/terminal/tutorials/powerline-setup
# Install-Module PANSIES -AllowClobber
# Install-Module PowerLine
# Import-Module PowerLine
#Set-PowerLinePrompt -SetCurrentDirectory -RestoreVirtualTerminal -Newline -Timestamp -Colors "#FFDD00", "#FF6600"
# Clear-Host

## Posh-git
# Installation:
#              Install-Module posh-git -Scope CurrentUser
#              Install-Module oh-my-posh -Scope CurrentUser
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt Paradox

## The line to setup terminal for a minimal powershell prompt IMPORTANT: Skip this if using posh-git
# Set-PowerLinePrompt -SetCurrentDirectory -RestoreVirtualTerminal -Newline -Timestamp -Colors "#FFDD00", "#FF6600"

# Define the aliases here
function chocoUpdate {
    cup all -y
}
function raspiPicoEnvSetup {
    cmd -cmd /K "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\VsDevCmd.bat"
}
# cd is an alias in powershell for Set-Location
function gitSetupScripts {
    Set-Location C:\Users\proti\Desktop\Personal_Code\Setup-Scripts
}

function gitEmbedProj {
    Set-Location "C:\Users\proti\Desktop\Personal_Code\# Embedded Projects"
}
function gitSysMon {
    Set-Location "C:\Users\proti\Desktop\Personal_Code\# Systen Monitor Projects"
}
function personalCode {
    Set-Location "C:\Users\proti\Desktop\Personal_Code\"
}

# Alias the functions above as "New-Alias <alias> <funcName>"
New-Alias updateall chocoUpdate
New-Alias pico raspiPicoEnvSetup
New-Alias setup gitSetupScripts
New-Alias embed gitEmbedProj
New-Alias sysmon gitSysMon
New-Alias dev personalCode


## Show custom aliases active in powershell
#Compare-Object (Get-Alias) (PowerShell -NoProfile { Get-Alias }) -Property Name # This was still too verbose

## Brute force write out what aliases this powershell session has Ugghhh.....
#echo "updateall (Update all programs using Chocolatey), pico (Setup Raspberry Pi Pico Dev Environment), setup (Setup-Scripts), embed (Embedded Projects), sysmon (System Monitor Projects)"

# The following Show-Markdown is only available from Powershell 7
@"
| Alias     | Description                             |\
|-----------|-----------------------------------------|\
| updateall | Update all programs using Chocolatey    |\
| pico      | Setup Raspberry Pi Pico Dev Environment |\
| setup     | Setup-Scripts                           |\
| embed     | Embedded Projects                       |\
| sysmon    | System Monitor Projects                 |\
| dev       | Peronal Code Folder                     |
"@ | Show-Markdown
