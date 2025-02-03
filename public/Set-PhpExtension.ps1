function Set-PhpExtension() {
    [CmdletBinding()]
    Param($ext, $path)

    Set-PhpDownloadCache "$ROOT_PHP\.cache"

    write-host "`nConfigure Php extention $path with $ext"

    #----------COMMON------
    if ('curl' -in $ext ){
        write-host "Activate curl"
        Enable-PhpExtension curl -path $path
    }  
    if ('ftp' -in $ext ){
        write-host "Activate ftp"
        Enable-PhpExtension ftp -path $path
    }  
    if ('gd' -in $ext ){
        write-host "Activate gd"
        Enable-PhpExtension gd -path $path
    }  
    if ('gettext' -in $ext ){
        write-host "Activate gettext"
        Enable-PhpExtension gettext -path $path
    }  
    if ('mbstring' -in $ext ){
        write-host "Activate mbstring"
        Enable-PhpExtension mbstring -path $path
    }  
    if ('openssl' -in $ext ){
        write-host "Activate openssl"
        Enable-PhpExtension openssl -path $path
    }  
    if ('soap' -in $ext ){
        write-host "Activate soap"
        Enable-PhpExtension soap -path $path
    }  
    if ('exif' -in $ext ){
        write-host "Activate exif"
        Enable-PhpExtension exif -path $path
    }  
    if ('fileinfo' -in $ext ){
        write-host "Activate fileinfo"
        Enable-PhpExtension fileinfo -path $path
    }  
    if ('bz2' -in $ext ){
        write-host "Activate bz2"
        Enable-PhpExtension bz2 -path $path
    }  
    if ('intl' -in $ext ){
        write-host "Activate intl"
        Enable-PhpExtension intl -path $path
    }  
    if ('sodium' -in $ext ){
        write-host "Activate sodium"
        Enable-PhpExtension sodium -path $path
    }  
    if ('zip' -in $ext ){
        write-host "Activate zip"
        Enable-PhpExtension zip -path $path
    }  
    #----------XMLRPC------
    if ('xmlrpc' -in $ext ){       
        if ((get-php $path).MajorMinorVersion -eq 7.4){
            write-host "Activate xmlrpc"
            Enable-PhpExtension xmlrpc -path $path            
        }else{  
            write-host "Install xmlrpc"
            Install-PhpExtension xmlrpc -path $path -MinimumStability beta
        }
    }
    #----------COM_DOTNET------
    if ('com' -in $ext ){
        write-host "Activate com_dotnet"
        Enable-PhpExtension com_dotnet -path $path
    }
    #----------SQLSRV------
    if ('sqlsrv' -in $ext ){
        write-host "Install sqlsrv & pdo_sqlsrv"
        Install-PhpExtension sqlsrv -path $path
        Install-PhpExtension pdo_sqlsrv -path $path
    }
    #----------ODBC------
    if ('odbc' -in $ext ){
        write-host "Activate odbc & pdo_odbc"
        Enable-PhpExtension odbc -path $path
        Enable-PhpExtension pdo_odbc -path $path
    }
     #----------MYSQL------
     if ('mysql' -in $ext ){
        write-host "Activate mysqli & pdo_mysql"
        Enable-PhpExtension mysqli -path $path
        Enable-PhpExtension pdo_mysql -path $path
    }
    #----------PGSQL-----
    if ('pgsql' -in $ext ){
        write-host "Activate pgsql & pdo_pgsql"
        Enable-PhpExtension pgsql -path $path
        Enable-PhpExtension pdo_pgsql -path $path
    }
    #----------SQLITE------
    if ('sqlite' -in $ext ){
        write-host "Activate sqlite3 & pdo_sqlite"
        Enable-PhpExtension sqlite3 -path $path
        Enable-PhpExtension pdo_sqlite -path $path
    }    
    #----------IMAGICK------
    if ('imagick' -in $ext ){
        write-host "Install imagick"
        Install-PhpExtension imagick -path $path
    }
    #----------OPCACHE------
    if ('opcache' -in $ext ){
        write-host "Activate opcache"
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
    #----------XDEBUG------
    if ('xdebug' -in $ext ){
        write-host "Install xdebug"     
        Install-PhpExtension xdebug -path $path     
        Set-PhpIniKey xdebug.mode "develop,debug" -path $path
    }
    #----------YAML------
    if ('yaml' -in $ext ){
        write-host "Install yaml"     
        Install-PhpExtension yaml -path $path     
    }
    #----------REDIS------
    if ('redis' -in $ext ){
        write-host "Install redis"     
        Install-PhpExtension redis -path $path     
    }
    #----------TRADER------
    if ('trader' -in $ext ){
        write-host "Install trader"     
        Install-PhpExtension trader -path $path     
    }
    #----------PHALCON------
    if ('phalcon' -in $ext ){
        write-host "Install phalcon"     
        Install-PhpExtension phalcon -path $path     
    }
    #fix php.ini for "php manager for iis" compatibility
    Update-PhpIniForIIS -path $path
}
