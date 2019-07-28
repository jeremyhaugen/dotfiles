# Install Windows Updates
Install-WindowsUpdate -acceptEula
Update-Help

# Windows Settings
Disable-BingSearch
Disable-GameBarTips

Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -DisableShowProtectedOSFiles -EnableShowFileExtensions -DisableShowRecentFilesInQuickAccess -DisableShowFrequentFoldersInQuickAccess
Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -Lock

# Windows Subsystems/Features
choco install Microsoft-Hyper-V-All -source windowsFeatures
choco install Microsoft-Windows-Subsystem-Linux -source windowsfeatures

# Tools
choco feature enable -n allowGlobalConfirmation
choco feature enable -n useRememberedArgumentsForUpgrades
choco install sysinternals
choco install git --params '"/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration"'
choco install vim-tux --params '"/InstallPopUp /RestartExplorer"'
choco install googlechrome
choco install sumatrapdf
choco install python2
choco install python3
choco install nodejs
choco install putty
choco install 7zip
#choco install grepwin
choco install astrogrep
choco install notepadplusplus -x86
choco install oldcalc
choco install beyondcompare
choco install virtualbox
choco install make
choco install visualstudio2017buildtools
choco install ripgrep
choco install fzf
choco install autohotkey --installargs '"/uiAccess"'
choco install libreoffice-fresh

# Configure BeyondCompare
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name Bcomp -Type String -Value "reg delete ""HKEY_CURRENT_USER\Software\Scooter Software\Beyond Compare 4"" /v CacheID /f"
Remove-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run -Name BCClipboard -ErrorAction 'silentlycontinue'

function AddCmdContextMenu {
    Param($Path)
    If (-Not (Test-Path $Path)) {
        New-Item -Path $Path | Out-Null
    }
    Set-ItemProperty -Path $Path -Name "(Default)" -Value "Open command window here"
    $commandPath = Join-Path -Path $Path -ChildPath command
    If (-Not (Test-Path $commandPath)) {
        New-Item -Path $commandPath | Out-Null
    }
    Set-ItemProperty -Path $(Join-Path -Path $Path -ChildPath command) -Name "(Default)" -Value "cmd.exe /s /k pushd ""%V"""
}

# Create "open command window here" in context menu
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
AddCmdContextMenu -Path HKCR:\Directory\shell\showcmd
AddCmdContextMenu -Path HKCR:\Directory\Background\shell\showcmd

# Remove all items from taskbar
Remove-Item "$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar*" -recurse -ErrorAction 'silentlycontinue'
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -recurse -ErrorAction 'silentlycontinue'

# Dont let apps use my advertising ID
If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
    New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

# Disable hotspot sharing
If (-Not (Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
    New-Item -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting | Out-Null
}
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting -Name value -Type DWord -Value 0

# Disable shared hotspot auto-connect
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots -Name value -Type DWord -Value 0

# Disable Bing search results in start menu
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0

# Disable the Lock Screen (the one before password prompt - to prevent dropping the first character)
If (-Not (Test-Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization)) {
    New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows -Name Personalization | Out-Null
}
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name NoLockScreen -Type DWord -Value 1

# Disable Xbox Gamebar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0

# Turn off People in Taskbar
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0
