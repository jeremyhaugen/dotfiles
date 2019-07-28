# Remove bloatware
Get-AppxPackage -AllUsers | where-object {$_.name -notlike "*store*"} | Remove-AppxPackage
