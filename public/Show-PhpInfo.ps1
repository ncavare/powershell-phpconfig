function Show-PhpInfo() {
    [CmdletBinding()]
    Param($path)

    if ($path -eq $null){
        $pathphp = "php.exe"
    }else{
        $pathphp = "$path\php.exe"
    }

    & $pathphp -v
    write-host ""
    & $pathphp -i | Select-String -Pattern 'imagick module =>','xdebug.mode =>','opcache.enable =>','sqlsrv support' 
}

