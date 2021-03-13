# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

## Run the stuff below before this profile is valid

#Install-Module PANSIES -AllowClobber
#Install-Module PowerLine
#Import-Module PowerLine

## The line to setup terminal for a minimal powershell prompt
#Set-PowerLinePrompt -SetCurrentDirectory -RestoreVirtualTerminal -Newline -Timestamp -Colors "#FFDD00", "#FF6600"


function chocoupdate {
    cup all -y
}
function pico_env {
cmd -cmd /K "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\VsDevCmd.bat"
}

New-Alias updateall chocoupdate
New-Alias pico pico_env

Set-PowerLinePrompt -SetCurrentDirectory -RestoreVirtualTerminal -Newline -Timestamp -Colors "#FFDD00", "#FF6600"
clear