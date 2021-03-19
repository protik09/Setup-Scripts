# Check if Powershell is running in Admin mode
& {
    $wid=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $prp=new-object System.Security.Principal.WindowsPrincipal($wid)
    $adm=[System.Security.Principal.WindowsBuiltInRole]::Administrator
    $IsAdmin=$prp.IsInRole($adm)
    if ($IsAdmin)
    {
        Clear-Host # Clear screen and continue program
    }
    else
    {
        (get-host).UI.RawUI.Backgroundcolor="DarkRed"
        echo "`nPlease run this script in an elevated Powershell.`n"
        [Console]::ResetColor()
        exit
    }
}

# Allow remote signed
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
Install-Module PANSIES -AllowClobber
Install-Module PowerLine
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser

# Install Fonts (https://www.powers-hell.com/2020/06/09/installing-fonts-with-powershell-intune/)
# Source file location
$source = 'https://github.com/adam7/delugia-code/releases/download/v2102.25/Delugia.Nerd.Font.Complete.ttf'
# Destination to save the file
$destination = 'C:\Users\proti\Downloads\Delugia.Nerd.Font.Complete.ttf'
$font_destination = 'C:\Users\proti\Downloads\'
#Download the file
Invoke-WebRequest -Uri $source -OutFile $destination

#region functions
function Install-Fonts
{
    param (
        [Parameter(Mandatory = $true)]
        [string]$FontFile
        )
        try {
            $font = $fontFile | split-path -Leaf
            If (!(Test-Path "c:\windows\fonts\$($font)")) {
                switch (($font -split "\.")[-1]) {
                    "TTF" {
                        $fn = "$(($font -split "\.")[0]) (TrueType)"
                        break
                    }
                    "OTF" {
                        $fn = "$(($font -split "\.")[0]) (OpenType)"
                        break
                    }
                }
                Copy-Item -Path $fontFile -Destination "C:\Windows\Fonts\$font" -Force
                New-ItemProperty -Name $fn -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $font
            }
        }
        catch 
        {
            write-warning $_.exception.message
        }
}
#endregion
foreach ($f in $(Get-ChildItem $font_destination))
{
    Install-Fonts -FontFile $f.fullName
}

# Install Powershell 7
choco install powershell-core -a

(get-host).UI.RawUI.Backgroundcolor="DarkGreen"
echo "`nPlease change Powershell and Visual Studio Code font to Delugia NerdFont.`n"
[Console]::ResetColor()
exit