function Update-PhpIniForIIS() {
    Param($path)
    (Get-Content -Path "$path\php.ini") |
        ForEach-Object {$_ -Replace 'extension=curl', 'extension=php_curl.dll'} |
        ForEach-Object {$_ -Replace 'extension=ftp', 'extension=php_ftp.dll'} |
        ForEach-Object {$_ -Replace 'extension=gd2', 'extension=php_gd2.dll'} |
        ForEach-Object {$_ -Replace 'extension=gd', 'extension=php_gd.dll'} |
        ForEach-Object {$_ -Replace 'extension=gettext', 'extension=php_gettext.dll' } |
        ForEach-Object {$_ -Replace 'extension=mbstring', 'extension=php_mbstring.dll'} | 
        ForEach-Object {$_ -Replace 'extension=openssl', 'extension=php_openssl.dll' } |
        ForEach-Object {$_ -Replace 'extension=soap', 'extension=php_soap.dll' } |      
        ForEach-Object {$_ -Replace 'extension=exif', 'extension=php_exif.dll'} |
        ForEach-Object {$_ -Replace 'extension=fileinfo', 'extension=php_fileinfo.dll'} |
        ForEach-Object {$_ -Replace 'extension=bz2', 'extension=php_bz2.dll'} |
        ForEach-Object {$_ -Replace 'extension=intl', 'extension=php_intl.dll'} |
        ForEach-Object {$_ -Replace 'extension=sodium', 'extension=php_sodium.dll' } |
        ForEach-Object {$_ -Replace 'extension=xmlrpc', 'extension=php_xmlrpc.dll' } |
        ForEach-Object {$_ -Replace 'extension=zip', 'extension=php_zip.dll'} |
        ForEach-Object {$_ -Replace 'extension=com_dotnet', 'extension=php_com_dotnet.dll' } |
       
        ForEach-Object {$_ -Replace 'extension=sqlsrv', 'extension=php_sqlsrv.dll'} |
        ForEach-Object {$_ -Replace 'extension=pdo_sqlsrv', 'extension=php_pdo_sqlsrv.dll'} |
        ForEach-Object {$_ -Replace 'extension=odbc', 'extension=php_odbc.dll' } |
        ForEach-Object {$_ -Replace 'extension=pdo_odbc', 'extension=php_pdo_odbc.dll'} |      
        ForEach-Object {$_ -Replace 'extension=mysqli', 'extension=php_mysqli.dll' } |      
        ForEach-Object {$_ -Replace 'extension=pdo_mysql', 'extension=php_pdo_mysql.dll' } |
        ForEach-Object {$_ -Replace 'extension=pgsql', 'extension=php_pgsql.dll'} |
        ForEach-Object {$_ -Replace 'extension=pdo_pgsql', 'extension=php_pdo_pgsql.dll'} |
        ForEach-Object {$_ -Replace 'extension=sqlite3', 'extension=php_sqlite3.dll'} |
        ForEach-Object {$_ -Replace 'extension=pdo_sqlite', 'extension=php_pdo_sqlite.dll'} |

        ForEach-Object {$_ -Replace 'extension=imagick', 'extension=php_imagick.dll'} |
        ForEach-Object {$_ -Replace 'zend_extension=opcache', 'zend_extension=php_opcache.dll'} |
        ForEach-Object {$_ -Replace 'zend_extension=xdebug', 'zend_extension=php_xdebug.dll'} |
        ForEach-Object {$_ -Replace 'extension=yaml', 'extension=php_yaml.dll'} |      
        ForEach-Object {$_ -Replace 'extension=redis', 'extension=php_redis.dll'} |
        ForEach-Object {$_ -Replace 'extension=trader', 'extension=php_trader.dll'} |
        ForEach-Object {$_ -Replace 'extension=phalcon', 'extension=php_phalcon.dll'} |
        
        Set-Content -Path "$path\php.ini"
}
