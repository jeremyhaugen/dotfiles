param (
    [string]$remote = $null,
    [switch]$nuke = $false
)

$InstallScriptName="install.ps1"
$NukeScriptName="nuke.ps1"

if ($remote)
{
    $InstallScript="$remote/$InstallScriptName"
    $NukeScript="$remote/$NukeScriptName"
}
else
{
    $InstallScript="$PSScriptRoot\$InstallScriptName"
    $NukeScript="$PSScriptRoot\$NukeScriptName"
}

#if ((Get-Command "choco" -ErrorAction SilentlyContinue) -eq $null)
#{
#}
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install boxstarter -y
Import-Module $env:appdata\Boxstarter\Boxstarter.Chocolatey\Boxstarter.Chocolatey.psd1 -DisableNameChecking -ErrorAction SilentlyContinue
if ($nuke)
{
    Install-BoxstarterPackage -PackageName $NukeScript
}
Install-BoxstarterPackage -PackageName $InstallScript
