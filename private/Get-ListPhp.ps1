function Get-ListPhp() {
    Param($path)

    $findphp  = @{} ; $index=1
    (Get-ChildItem -Path $ROOT_PHP -Directory| where {$_.Name -like "php-*"})| Foreach { 
            $findphp[$index.tostring()] = $ROOT_PHP +'\' + $_.Name.tostring() ; $index++ 
    }
    return $findphp;
}