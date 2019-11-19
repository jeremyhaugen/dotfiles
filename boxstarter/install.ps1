# Install Windows Updates
Install-WindowsUpdate -acceptEula
Update-Help

# Windows Settings
Disable-BingSearch
Disable-GameBarTips

Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -DisableShowProtectedOSFiles -EnableShowFileExtensions -DisableShowRecentFilesInQuickAccess -DisableShowFrequentFoldersInQuickAccess
Set-TaskbarOptions -Size Small -Dock Bottom -Combine Always -Lock

# Windows Subsystems/Features
choco install wsl
# wslconfig outputs with null between every character
if (-Not (wslconfig /list | select-string "U\0?b\0?u\0?n\0?t\0?u")) {
    Write-Host "Installing Ubuntu for WSL"
    $UbuntuAppx="$env:temp/Ubuntu1804.appx"
    Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile $UbuntuAppx -UseBasicParsing
    Add-AppxPackage $UbuntuAppx
    Remove-Item $UbuntuAppx
    Write-Host "Finished installing Ubuntu for WSL"
}

# Enable windows sandbox
choco install Containers-DisposableClientVM -source windowsFeatures

# Enable Hyper-V
choco install Microsoft-Hyper-V-All -source windowsFeatures

# Tools
choco feature enable -n allowGlobalConfirmation
choco feature enable -n useRememberedArgumentsForUpgrades
choco install sysinternals
choco install git --params '"/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration"'
choco install vim --params '"/NoDefaultVimrc /NoDesktopShortcuts /RestartExplorer"'
choco install googlechrome
choco install adobereader
choco install vlc
choco install irfanview
choco install irfanviewplugins
choco install python
choco install nodejs
choco install putty.install
choco install winscp
choco install agentransack
choco install 7zip
choco install notepadplusplus -x86
choco install oldcalc
choco install beyondcompare
choco install make
choco install visualstudio2017buildtools
choco install visualstudio2017-workload-vctools
choco install ripgrep
choco install fzf
choco install autohotkey --installargs '"/uiAccess"'
choco install hashtab
If ("$env:QC_SDD_FILER" -notmatch "SAN") {
    # Personal PC
    choco install libreoffice-fresh
    choco install lastpass
    choco install lastpass-for-applications
    choco install google-drive-file-stream

    $computername = "Jeremy-PC"
    if ($env:computername -ne $computername) {
        Rename-Computer -NewName $computername
    }
}

pip install flake8
pip install requests
pip install numpy
pip install scipy
pip install matplotlib
pip install pypiwin32
pip install psutil
npm install eslint
npm install tslint
npm install tsserver

# Install theme
$ThemepackUri = "http://download.microsoft.com/download/F/D/8/FD80790C-926E-40C4-A3AA-125F91DF49DD/NASAHiddenUniverse.themepack"
$ThemepackFile="$env:temp/NASAHiddenUniverse.themepack"
Invoke-WebRequest -Uri $ThemepackUri -OutFile $ThemepackFile -UseBasicParsing
Start-Process $ThemepackFile
Start-Sleep -s 10
(New-Object -comObject Shell.Application).Windows() | where-object {$_.LocationName -eq "Personalization"} | foreach-object {$_.quit()}
Remove-Item -Path $ThemepackFile

# Configure BeyondCompare
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name Bcomp -Type String -Value "reg delete ""HKEY_CURRENT_USER\Software\Scooter Software\Beyond Compare 4"" /v CacheID /f"
Remove-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run -Name BCClipboard -ErrorAction 'silentlycontinue'

# Configure start menu and taskbar layout
$layoutfile = "$env:USERPROFILE\dotfiles\layout.xml"
# Remove previous pins from taskbar
Remove-Item -Path "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar*" -recurse -ErrorAction 'silentlycontinue'
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -recurse -ErrorAction 'silentlycontinue'
# Apply the layout.xml
Set-ItemProperty -Path HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name LockedStartLayout -Type DWord -Value 1
Set-ItemProperty -Path HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name StartLayoutFile -Type String -Value $layoutfile
# Update the layoutfile to force the taskbar icons to be reset
(Get-ChildItem $layoutfile).LastWriteTime = Get-Date
# Restart explorer to show the new layout
Get-Process -ProcessName explorer | Stop-Process

# Don't prompt for new app associations when new programs are installed
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name NoNewAppAlert -Type DWord -Value 1

# Set the default file associations
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -Name DefaultAssociationsConfiguration -Type String -Value "$env:USERPROFILE\dotfiles\file_associations.xml"

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

# Automatically run the Autohotkey script
New-Item -itemtype symboliclink -path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup" -name winkey.ahk -value $HOME\dotfiles\winkey.ahk -ErrorAction SilentlyContinue

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

# Disable sticky keys
Set-ItemProperty -Path "HKCU:Control Panel\Accessibility\StickyKeys" -Name Flags -Type String -Value "506"
Set-ItemProperty -Path "HKCU:Control Panel\Accessibility\Keyboard Response" -Name Flags -Type String -Value "122"
Set-ItemProperty -Path "HKCU:Control Panel\Accessibility\ToggleKeys" -Name Flags -Type String -Value "58"

# Hide taskbar search button
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name SearchboxTaskbarMode -Type DWord -Value 0

# Hide taskbar taskview button
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowTaskViewButton -Type DWord -Value 0

if (-Not (Test-Path "$HOME/dotfiles")) {
    git clone https://github.com/jeremyhaugen/dotfiles.git $HOME\dotfiles
    git -C $HOME/dotfiles submodule update --init
}

New-Item -itemtype symboliclink -path $HOME -name _vimrc -value $HOME\dotfiles\.vimrc -ErrorAction SilentlyContinue
New-Item -itemtype symboliclink -path $HOME -name vimfiles -value $HOME\dotfiles\vim -ErrorAction SilentlyContinue
New-Item -itemtype symboliclink -path $HOME -name .eslintrc.json -value $HOME\dotfiles\.eslintrc.json -ErrorAction SilentlyContinue
New-Item -itemtype symboliclink -path $HOME -name .gitconfig -value $HOME\dotfiles\.gitconfig -ErrorAction SilentlyContinue

# Hibernate when pressing power key
powercfg -setdcvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 2
powercfg -setacvalueindex SCHEME_CURRENT SUB_BUTTONS PBUTTONACTION 2

# Hibernate when closing the lid
powercfg -setdcvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 2
powercfg -setacvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 2

# Apply the current settings
powercfg -SetActive SCHEME_CURRENT

# Show hibernate in start power menu
If (-Not (Test-Path "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings")) {
    New-Item -Path HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings | Out-Null
}
Set-ItemProperty -Path "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name ShowHibernateOption -Type DWord -Value 1

# Hide sleep in start power menu
Set-ItemProperty -Path "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name ShowSleepOption -Type DWord -Value 0

# Don't go to sleep when on AC power
powercfg -change -hibernate-timeout-ac 0
powercfg -change -standby-timeout-ac 0

# Remove .lnk files from desktop
$DesktopDir = [Environment]::GetFolderPath("Desktop")
$CommonDesktopDir = [Environment]::GetFolderPath("CommonDesktopDirectory")
Get-ChildItem -Path $DesktopDir -Filter "*.lnk" | Foreach {
    Remove-Item $_.FullName -ErrorAction 'silentlycontinue'
}
Get-ChildItem -Path $CommonDesktopDir -Filter "*.lnk" | Foreach {
    Remove-Item $_.FullName -ErrorAction 'silentlycontinue'
}
