function Install-PhpFull(){
    [CmdletBinding()]
    Param($version,$ext,$limit,$mode)
    begin {
        $path = $null
    }
    process {
        Set-PhpDownloadCache "$ROOT_PHP\.cache"

        $chose_version = ($version -split '-')[0]
        $chose_tread = ($version -split '-')[1]
        $chose_archi = ($version -split '-')[2]
        if ($chose_tread -eq 'nts') {$is_tread_safe=$false }else{ $is_tread_safe=$true}

        #Install Php
        $path = "$ROOT_PHP\php-$chose_version-$chose_tread-$chose_archi"
        write-host "Install php $chose_version in $path"
        Install-Php -Version $chose_version -Architecture $chose_archi -ThreadSafe $is_tread_safe -InstallVC -Path $path -TimeZone "Europe/Paris" -InitialPhpIni Production -Force

        #Update-PhpCAInfo
        write-host "Update cacert.pem"
        Update-PhpCAInfo -Path $path

        #Fix php.ini 
        (Get-Content -Path "$path\php.ini") |
            ForEach-Object {$_ -Replace ';extension=exif      ; Must be after mbstring as it depends on it', ';extension=exif'} |
            ForEach-Object {$_ -Replace ';extension=xsl', ";extension=xsl`nextension=php_com_dotnet.dll" } |          
            ForEach-Object {$_ -Replace ';extension=xsl', ";extension=xsl`n;extension=php_sqlsrv.dll" } |  
            ForEach-Object {$_ -Replace ';extension=xsl', ";extension=xsl`n;extension=php_pdo_sqlsrv.dll" } | 
            ForEach-Object {$_ -Replace ';extension=xsl', ";extension=xsl`n;extension=php_imagick.dll" } |
            ForEach-Object {$_ -Replace ';extension=xsl', ";extension=xsl`n;zend_extension=php_xdebug.dll"} |
            Set-Content -Path "$path\php.ini"

    
        #Configure session_save_path
        write-host "Configure session.save_path to $path\session_save_path\"
        New-Item -Path "$path\session_save_path\"  -ItemType Directory -Force | Out-Null
        Set-PhpIniKey session.save_path "$path\session_save_path\" -path $path

        #Configure error_log
        write-host "Configure error_log to $path\error_log\php_errors.log"
        New-Item -Path "$path\error_log\"  -ItemType Directory -Force | Out-Null
        Set-PhpIniKey error_log "$path\error_log\php_errors.log" -path $path

        #Configure upload_tmp_dir
        write-host "Configure upload_tmp_dir to $path\upload_tmp_dir\"
        New-Item -Path "$path\upload_tmp_dir\"  -ItemType Directory -Force | Out-Null
        Set-PhpIniKey upload_tmp_dir "$path\upload_tmp_dir\" -path $path

        #Configure sys_temp_dir
        write-host "Configure sys_temp_dir to $path\sys_temp_dir\"
        New-Item -Path "$path\sys_temp_dir\"  -ItemType Directory -Force | Out-Null  
        Set-PhpIniKey sys_temp_dir "$path\sys_temp_dir\" -path $path 

        #Configure security
        Set-PhpIniKey expose_php Off -path $path

        Set-PhpLimit -limit $limit -path $path 

        Set-PhpExtension -ext  $ext -path $path 

        Set-PhpMode -mode $mode -path $path

        if ((Get-PhpSwitcher) -ne $null){
            $namephp = Get-PhpNameForSwitcher $path 
            write-host  "Add php $namephp to switcher"   
            Add-PhpToSwitcher -Name $namephp -Path $path -Force
        }
    }
    end {
        $path
    }      
}
