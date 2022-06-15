
function Set-PhpSwitcher() {
    [CmdletBinding()]
    Param()

    write-host "`nConfigure Php switcher"

    if ((Get-Php) -ne $null){
        if ((Get-Php)[0].folder.tostring() -ne "$ROOT_PHP\php"){
            write-host  "Remove folder in path : $((Get-Php)[0].folder.tostring())"
            Set-EnvPath -Operation Remove -Path (Get-Php)[0].folder.tostring()
        }
    }
    
    if ((Get-Php) -eq $null){
        write-host  "Add folder to path : $ROOT_PHP\php"
        Set-EnvPath -Operation Add -Path "$ROOT_PHP\php" -Persist System -CurrentProcess
    }		

    if ((Get-PhpSwitcher) -eq $null){
        write-host  "Initialize php switcher"
        Initialize-PhpSwitcher -Alias "$ROOT_PHP\php" -Scope AllUsers
    }

    if ((Get-PhpSwitcher) -ne $null){
        (Get-PhpSwitcher).Targets.Keys | ForEach {
            write-host  "Remove php $_ from Switcher"
            Remove-PhpFromSwitcher -Name $_ -Force 
        }
    }
                    
    Get-ChildItem -Path $ROOT_PHP -Directory| where {$_.name -like "php-*"} | ForEach-Object{
        $namephp = Get-PhpNameForSwitcher $_.FullName  
        write-host  "Add php $namephp to switcher"   
        Add-PhpToSwitcher -Name $namephp -Path $_.FullName -Force
    }

    write-host  "Switch to $namephp"   

    Switch-php $namephp  -Force
}
