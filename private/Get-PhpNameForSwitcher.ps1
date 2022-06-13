
function Get-PhpNameForSwitcher ($path) {
    $phpinfo = (Get-Php -path $path)
    $MajorMinorVersion = $phpinfo.MajorMinorVersion
    if ($phpinfo.Architecture -eq 'x64') {$Architecture='x'} else { $Architecture=''}
    if ($phpinfo.ThreadSafe -eq 'x64') {$ThreadSafe='t'} else { $ThreadSafe=''}
    return "$($MajorMinorVersion)$($Architecture)$($ThreadSafe)"    
}