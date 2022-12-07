## Run the stuff below if the script gives access issues
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
# Set ExecutionPolicy Unrestricted

## Posh-git
# Installation:
# Check https://ohmyposh.dev/docs/installation/windows

# Set the prompt theme (defaults to 'agnoster' for me)
# ! Note: You have to do this step first (or it still won't work)
# Set-PoshPrompt

# Ensure its up to date
# Update-Module oh-my-posh

# Define the aliases here
function chocoUpdate {
    cup all -y
}
function raspiPicoEnvSetup {
    cmd -cmd /K "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\VsDevCmd.bat"
}
# cd is an alias in powershell for Set-Location
function gitSetupScripts {
    Set-Location "C:\Users\proti\Desktop\Personal Code\Setup-Scripts"
}

function gitEmbedProj {
    Set-Location "C:\Users\proti\Desktop\Personal Code\# Embedded Projects"
}
function gitSysMon {
    Set-Location "C:\Users\proti\Desktop\Personal Code\# Systen Monitor Projects"
}
function personalCode {
    Set-Location "C:\Users\proti\Desktop\Personal Code"
}
function downloads {
    Set-Location "C:\Users\proti\Downloads\"
}
function dir{
    Get-ChildItem
}

# Alias the functions above as "New-Alias <alias> <funcName>"
New-Alias updateall chocoUpdate
# New-Alias pico raspiPicoEnvSetup
New-Alias setup gitSetupScripts
# New-Alias embed gitEmbedProj
# New-Alias sysmon gitSysMon
New-Alias dev personalCode
New-Alias download downloads
New-Alias down downloads
New-Alias ll dir


## Show custom aliases active in powershell
#Compare-Object (Get-Alias) (PowerShell -NoProfile { Get-Alias }) -Property Name # This was still too verbose

## Brute force write out what aliases this powershell session has Ugghhh.....
#echo "updateall (Update all programs using Chocolatey), pico (Setup Raspberry Pi Pico Dev Environment), setup (Setup-Scripts), embed (Embedded Projects), sysmon (System Monitor Projects)"

# The following Show-Markdown is only available from Powershell 7
@"
| Commands                | Description                             |\
|-------------------------|-----------------------------------------|\
| updateall               | Update all programs using Chocolatey    |\
| pico                    | Setup Raspberry Pi Pico Dev Environment |\
| setup                   | Setup-Scripts                           |\
| embed                   | Embedded Projects                       |\
| sysmon                  | System Monitor Projects                 |\
| dev                     | Peronal Code Folder                     |\
| down                    | Downloads Folder                        |\
| fuck                    | Fix mistyped console commands           |\
| tldr                    | Help for various commands               |\
| winget upgrade --all    | Update all programs using winget        |
"@ | Show-Markdown

## Init oh my posh

# Local init
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/M365Princess.omp.json" | Invoke-Expression

# Remote init
oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/M365Princess.omp.json' | Invoke-Expression

## Add fuck capability to powershell from "https://github.com/nvbn/thefuck"
$env:PYTHONIOENCODING = "utf-8" # Bypass annoying pyhton error
Invoke-Expression "$(thefuck --alias)" 