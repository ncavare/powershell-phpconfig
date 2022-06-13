function Remove-Php() {
    [CmdletBinding()]
    Param($path)

    write-host "`nRemove Php $path"

    if ((Get-PhpSwitcher) -ne $null){
        $namephp = Get-PhpNameForSwitcher $path 
        write-host  "Remove php $namephp from switcher"   
        Remove-PhpFromSwitcher -Name $namephp -Force
    }   

    write-host  "Uninstall-Php $path"
    Uninstall-Php -path $path
}