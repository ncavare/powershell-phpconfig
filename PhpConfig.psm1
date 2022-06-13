#Requires -Modules PhpManager

$scripts = @(Get-ChildItem -Path $PSScriptRoot\private\*.ps1 -Depth 1) + @(Get-ChildItem -Path $PSScriptRoot\public\*.ps1 -Depth 1)
foreach ($script in $scripts) {
    Write-Debug "Including $($script.FullName)"
    . $script.FullName
}
Export-ModuleMember -Function $scripts.Basename
