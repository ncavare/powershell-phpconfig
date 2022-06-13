function Update-PhpIniForIIS() {
    Param($path)
    (Get-Content -Path "$path\php.ini") |
        ForEach-Object {$_ -Replace 'extension=bz2', 'extension=php_bz2.dll'} |
        ForEach-Object {$_ -Replace 'extension=curl', 'extension=php_curl.dll'} |
        ForEach-Object {$_ -Replace 'extension=fileinfo', 'extension=php_fileinfo.dll'} |
        ForEach-Object {$_ -Replace 'extension=gd2', 'extension=php_gd2.dll'} |
        ForEach-Object {$_ -Replace 'extension=gd', 'extension=php_gd.dll'} |
        ForEach-Object {$_ -Replace 'extension=gettext', 'extension=php_gettext.dll' } |
        ForEach-Object {$_ -Replace 'extension=intl', 'extension=php_intl.dll'} |
        ForEach-Object {$_ -Replace 'extension=mbstring', 'extension=php_mbstring.dll'} |        
        ForEach-Object {$_ -Replace 'extension=exif', 'extension=php_exif.dll'} |
        ForEach-Object {$_ -Replace 'extension=mysqli', 'extension=php_mysqli.dll' } |
        ForEach-Object {$_ -Replace 'extension=odbc', 'extension=php_odbc.dll' } |
        ForEach-Object {$_ -Replace 'extension=openssl', 'extension=php_openssl.dll' } |
        ForEach-Object {$_ -Replace 'extension=pdo_mysql', 'extension=php_pdo_mysql.dll' } |
        ForEach-Object {$_ -Replace 'extension=soap', 'extension=php_soap.dll' } |       
        ForEach-Object {$_ -Replace 'extension=sodium', 'extension=php_sodium.dll' } |
        ForEach-Object {$_ -Replace 'extension=sqlsrv', 'extension=php_sqlsrv.dll'} |
        ForEach-Object {$_ -Replace 'extension=pdo_sqlsrv', 'extension=php_pdo_sqlsrv.dll'} |
        ForEach-Object {$_ -Replace 'extension=imagick', 'extension=php_imagick.dll'} |
        ForEach-Object {$_ -Replace 'zend_extension=opcache', 'zend_extension=php_opcache.dll'} |
        ForEach-Object {$_ -Replace 'zend_extension=xdebug', 'zend_extension=php_xdebug.dll'} |
        Set-Content -Path "$path\php.ini"
}
