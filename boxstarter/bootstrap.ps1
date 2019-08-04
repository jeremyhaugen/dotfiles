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

# Bootstrap the ChocolateyInstall so we can import Update-SessionEnviroment
$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

Update-SessionEnvironment
echo $env:PSModulePath
Import-Module Boxstarter.Chocolatey
if ($nuke)
{
    Install-BoxstarterPackage -PackageName $NukeScript
}
Install-BoxstarterPackage -PackageName $InstallScript
