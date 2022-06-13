function Set-PhpMode() {
    [CmdletBinding()]
    Param($mode,$path)

    write-host "`nConfigure dev/prod mode ",$path

     #----------MODE DEV------
     if ($mode -eq 'dev'){
        write-host "Configure 'dev' mode"
        Set-PhpIniKey error_reporting "E_ALL" -path $path
        Set-PhpIniKey display_errors "On" -path $path
        Set-PhpIniKey html_errors "On" -path $path
        Set-PhpIniKey log_errors "On" -path $path
        Set-PhpIniKey fastcgi.logging 0 -path $path
    }else{
        write-host "Configure 'prod' mode"
        Set-PhpIniKey error_reporting "E_ALL & ~E_DEPRECATED & ~E_STRICT" -path $path
        Set-PhpIniKey display_errors "Off" -path $path       
        Set-PhpIniKey html_errors "Off" -path $path
        Set-PhpIniKey log_errors "On" -path $path
        Set-PhpIniKey fastcgi.logging 0 -path $path
    }
}
