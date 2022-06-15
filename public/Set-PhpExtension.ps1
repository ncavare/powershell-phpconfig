function Set-PhpExtension() {
    [CmdletBinding()]
    Param($ext, $path)

    Set-PhpDownloadCache "$ROOT_PHP\.cache"

    write-host "`nConfigure Php extention $path with $ext"

    #----------COMMON------
    if ('common' -in $ext ){
        write-host "Activate curl,gd,gettext,mbstring,openssl,soap,exif,fileinfo,bz2,intl,sodium"
        Enable-PhpExtension curl,gd,gettext,mbstring,openssl,soap,exif,fileinfo,bz2,intl,sodium -path $path
    }  
    #----------COM_DOTNET------
    if ('com' -in $ext ){
        write-host "Install com_dotnet"
        Enable-PhpExtension com_dotnet -path $path
    }
    #----------ODBC------
    if ('odbc' -in $ext ){
        write-host "Install odbc & pdo_odbc"
        Enable-PhpExtension odbc -path $path
        Enable-PhpExtension pdo_odbc -path $path
    }
    #----------PGSQL-----
    if ('pgsql' -in $ext ){
        write-host "Install pgsql & pdo_pgsql"
        Enable-PhpExtension pgsql -path $path
        Enable-PhpExtension pdo_pgsql -path $path
    }
    #----------MYSQL------
    if ('sqlite' -in $ext ){
        write-host "Install sqlite3 & pdo_sqlite"
        Enable-PhpExtension sqlite3 -path $path
        Enable-PhpExtension pdo_sqlite -path $path
    }
     #----------MYSQL------
     if ('mysql' -in $ext ){
        write-host "Install mysqli & pdo_mysql"
        Enable-PhpExtension mysqli -path $path
        Enable-PhpExtension pdo_mysql -path $path
    }
    #----------SQLSRV------
    if ('sqlsrv' -in $ext ){
        write-host "Install sqlsrv & pdo_sqlsrv"
        Install-PhpExtension sqlsrv -path $path
        Install-PhpExtension pdo_sqlsrv -path $path
    }
    #----------IMAGICK------
    if ('imagick' -in $ext ){
        write-host "Install imagick"
        Install-PhpExtension imagick -path $path
    }
    #----------XDEBUG------
    if ('xdebug' -in $ext ){
        write-host "Install xdebug"     
        Install-PhpExtension xdebug -path $path     
        Set-PhpIniKey xdebug.mode "develop,debug" -path $path
    }
    #----------OPCACHE------
    if ('opcache' -in $ext ){
        write-host "Install opcache"
        Enable-PhpExtension opcache -path $path 
        Set-PhpIniKey opcache.enable 1 -path $path
        Set-PhpIniKey opcache.enable_cli 1 -path $path
        Set-PhpIniKey opcache.memory_consumption 512 -path $path
        Set-PhpIniKey opcache.interned_strings_buffer 24 -path $path
        Set-PhpIniKey opcache.max_accelerated_files 50000 -path $path
        Set-PhpIniKey opcache.validate_timestamps 1 -path $path
        Set-PhpIniKey opcache.revalidate_freq 2 -path $path
        Set-PhpIniKey opcache.cache_id '${APP_POOL_ID}' -path $path
    }
    #----------XMLRPC------
    if ('xmlrpc' -in $ext ){
        write-host "Install xmlrpc"
        Enable-PhpExtension xmlrpc -path $path
    }
    #fix php.ini for "php manager for iis" compatibility
    Update-PhpIniForIIS -path $path

    #reset files permissions
    icacls $path /T /Q /C /RESET | Out-Null
}
