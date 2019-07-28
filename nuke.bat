"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$remote='https://raw.githubusercontent.com/jeremyhaugen/dotfiles/master/boxstarter'; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($remote'/bootstrap.ps1') -remote $remote -nuke)"

