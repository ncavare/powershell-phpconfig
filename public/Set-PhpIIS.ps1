function Set-PhpIIS() {
    [CmdletBinding()]
    Param($site,$path)

    write-host "`nConfigure Php $path on IIS site $site"

    #Configure fastcgi
    Set-PhpIniKey cgi.force_redirect 0 -path $path
    Set-PhpIniKey cgi.fix_pathinfo 1 -path $path
    Set-PhpIniKey fastcgi.impersonate 1 -path $path
    Set-PhpIniKey fastcgi.logging 1 -path $path

    if ($site -eq 'GLOBAL') { $site='' } 
    $versionphp = (Get-Php  $path).version  	
    write-host "Install php $versionphp with path $path\php-cgi.exe on $site"


    cmd /c "%systemroot%\system32\inetsrv\appcmd.exe set config /section:system.webServer/fastCgi /-`"[fullPath='$path\php-cgi.exe']`"" | Out-Null
    cmd /c "%systemroot%\system32\inetsrv\appcmd.exe set config /section:system.webServer/fastCgi /+`"[fullPath='$path\php-cgi.exe']`""| Out-Null
    cmd /c "%systemroot%\system32\inetsrv\appcmd.exe set config /section:system.webServer/fastCgi /`"[fullPath='$path\php-cgi.exe']`".instanceMaxRequests:10000"| Out-Null
    cmd /c "%systemroot%\system32\inetsrv\appcmd.exe set config /section:system.webServer/fastCgi /`"[fullPath='$path\php-cgi.exe']`".activityTimeout:360"| Out-Null
    cmd /c "%systemroot%\system32\inetsrv\appcmd.exe set config /section:system.webServer/fastCgi /`"[fullPath='$path\php-cgi.exe']`".monitorChangesTo:$path\php.ini"| Out-Null
    cmd /c "%systemroot%\system32\inetsrv\appcmd.exe set config /section:system.webServer/fastCgi /+`"[fullPath='$path\php-cgi.exe']`".environmentVariables.[name='PHP_FCGI_MAX_REQUESTS',value='10000']"| Out-Null
    cmd /c "%systemroot%\system32\inetsrv\appcmd.exe set config /section:system.webServer/fastCgi /+`"[fullPath='$path\php-cgi.exe']`".environmentVariables.[name='PHPRC',value='$path\']"| Out-Null

    cmd /c "%systemroot%\system32\inetsrv\appcmd.exe set config $site /section:system.webServer/handlers /-`"[name='php-$versionphp']`" /commit:apphost"| Out-Null
    cmd /c "%systemroot%\system32\inetsrv\appcmd.exe set config $site /section:system.webServer/handlers /+`"[name='php-$versionphp',path='*.php',verb='GET,POST,PUT,DELETE,PATCH,HEAD',modules='FastCgiModule',scriptProcessor='$path\php-cgi.exe',resourceType='Either']`" /commit:apphost"| Out-Null
    cmd /c "%systemroot%\system32\inetsrv\appcmd.exe set config $site /section:system.webServer/handlers /accessPolicy:Read,Script /commit:apphost"| Out-Null
    
}
