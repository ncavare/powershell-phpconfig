
function Show-PhpConfig() {
    [CmdletBinding()]
    Param($chose_action)
    
    write-host  
    if ($chose_action -eq $null){
        write-host "-----------------PHP CONFIG $($MyInvocation.MyCommand.ScriptBlock.Module.Version)---------------------"    
        write-host "`r`nChoose an action :"
        $chose  = Show-Menu @('Install php';'Configure php extension';'Configure mode dev/prod';'Update php';'Remove php';'Install php switcher';'Switch php version';'Configure iis';'Exit') -ReturnIndex
        switch ($chose){
            0{ $chose_action="install"}
            1{ $chose_action="configure"}
            2{ $chose_action="modedevprod"}
            3{ $chose_action="update"}
            4{ $chose_action="remove"}
            5{ $chose_action="installswitcher"}
            6{ $chose_action="switchphp"}
            7{ $chose_action="iis"}
            8{ Return }
        }
    }

    if (($chose_action -eq "configure") -or ($chose_action -eq "modedevprod")  -or ($chose_action -eq "update") -or ($chose_action -eq "remove")){  
        write-host "`r`nChoose an install php :"
        $listphp=$(Get-ListPhp).Values  | Select -Unique 
        $path  = Show-Menu  $listphp
    }
    if ($chose_action -eq "switchphp"){
        write-host "`r`nChoose an install php :"
        $listphp=$(Get-PhpSwitcher).targets.Keys  | Select -Unique 
        $path  = Show-Menu  $listphp
    }
    if ($chose_action -eq "install"){  
        write-host "`r`nChoose a version :"
        $chose  = Show-Menu @('PHP 7.4';'PHP 8.0';'PHP 8.1';'PHP 8.2';'PHP 8.3';'Exit') -ReturnIndex
        switch ($chose){
            0{ $chose_version="7.4"}
            1{ $chose_version="8.0"}
            2{ $chose_version="8.1"}
            3{ $chose_version="8.2"}
            4{ $chose_version="8.3"}
            5{ Return }
        }
        write-host "`r`nChoose a version :"
        $chose  = Show-Menu @('Non Thread Safe';'Thread Safe';'Exit') -ReturnIndex
        switch ($chose){
            0{ $chose_tread='nts' }
            1{ $chose_tread='ts' }   
            2{ Return }  	
        }
        write-host "`r`nChoose a version :"
        $chose  = Show-Menu @('x64';'x86';'Exit') -ReturnIndex
        switch ($chose){
            0{ $chose_archi='x64'; } 
            1{ $chose_archi='x86'; }                
            2{ Return }	
        }         
    }

    if (($chose_action -eq "install") -or ($chose_action -eq "configure")) {   
        $ext = @(
            [pscustomobject]@{name="curl";desc="curl"}
            [pscustomobject]@{name="gd";desc="gd"}
            [pscustomobject]@{name="gettext";desc="gettext"}
            [pscustomobject]@{name="mbstring";desc="mbstring"}
            [pscustomobject]@{name="openssl";desc="openssl"}
            [pscustomobject]@{name="soap";desc="soap"}
            [pscustomobject]@{name="exif";desc="exif"}
            [pscustomobject]@{name="fileinfo";desc="fileinfo"}
            [pscustomobject]@{name="bz2";desc="bz2"}
            [pscustomobject]@{name="intl";desc="intl"}
            [pscustomobject]@{name="sodium";desc="sodium"}  
        )
        Write-Host "`r`nSelect commun extension with 'space' validate with 'enter'"
        $extcom=Show-Menu -MenuItems $ext -MultiSelect -InitialSelection @(0,1,2,3,4,5,6,7,8,9,10) -MenuItemFormatter { $Args | Select -Exp desc }
        

         $ext = @(
            [pscustomobject]@{name="sqlsrv";desc="sqlsrv & pdo_sqlsrv"}
            [pscustomobject]@{name="odbc";desc="odbc & pdo_odbc"}
            [pscustomobject]@{name="mysql";desc="mysqli & pdo_mysql"}
            [pscustomobject]@{name="pgsql";desc="pgsql & pdo_pgsql"}           
            [pscustomobject]@{name="sqlite";desc="sqlite3 & pdo_sqlite"}
         )
        Write-Host "`r`nSelect sql extension with 'space' validate with 'enter'"
        $extsql=Show-Menu -MenuItems $ext -MultiSelect -InitialSelection @(0,1,2) -MenuItemFormatter { $Args | Select -Exp desc }
                       
        $ext = @(
            [pscustomobject]@{name="xmlrpc";desc="xmlrpc"}
            [pscustomobject]@{name="com";desc="com_dotnet"}
            [pscustomobject]@{name="imagick";desc="imagick"}   
            [pscustomobject]@{name="opcache";desc="opcache"}   #verif
            [pscustomobject]@{name="xdebug";desc="xdebug"}
            [pscustomobject]@{name="yaml";desc="yaml"}
            [pscustomobject]@{name="redis";desc="redis"}
            [pscustomobject]@{name="trader";desc="trader"}        
        )
        Write-Host "`r`nSelect extra extension with 'space' validate with 'enter'"
        $extra=Show-Menu -MenuItems $ext -MultiSelect -InitialSelection @(0,1,2,3) -MenuItemFormatter { $Args | Select -Exp desc }

        $ext=$extcom + $extsql + $extra

        $ext=$ext | WHERE name -ne $null  | Select -Exp name
    }

    if (($chose_action -eq "install") -or ($chose_action -eq "modedevprod")) {
        write-host "`r`nMode DEV / PROD :"
        $chose  = Show-Menu @('DEV => error_reporting=E_ALL / display_errors=on';'PROD => error_reporting E_ALL & ~E_DEPRECATED & ~E_STRICT / display_errors=off';'Exit') -ReturnIndex
        switch ($chose){
            0{ $mode='dev'; }
            1{ $mode='prod'; }     
            2{ Return }	
        }     
    }

    if ($chose_action -eq "install"){          
        $version = "$chose_version-$chose_tread-$chose_archi"
        $path = Install-PhpFull -version $version -ext $ext -limit 'high' -mode $mode
        Show-PhpInfo $path      
    }

    if ($chose_action -eq "configure"){         
        Set-PhpExtension -ext  $ext  -path $path
        Show-PhpInfo $path
    }

    if ($chose_action -eq "modedevprod"){        
        Set-PhpMode -mode $mode -path $path
        Show-PhpInfo $path
    }      

    if ($chose_action -eq "update"){
        Update-Php -path $path  
    }

    if ($chose_action -eq "remove"){
        Remove-Php -path $path  
    }

    if ($chose_action -eq "installswitcher"){       
        Set-PhpSwitcher       
    }

    if ($chose_action -eq "switchphp"){
        Switch-php -name $path -force
        Show-PhpInfo
    }

    if ($chose_action -eq "iis"){
        if (Test-Administrator){
            write-host "`r`nChoose a web site :"
            $listphp=$(Get-ListIIS).Values  | Select -Unique 
            $site  = Show-Menu  $listphp                

            write-host "`r`nChoose an install php :"
            $listphp=$(Get-ListPhp).Values  | Select -Unique 
            $path  = Show-Menu  $listphp
                
            Set-PhpIIS -site $site -path $path
        }else{
            Start-Process -FilePath 'powershell.exe' -ArgumentList "-Command Show-PhpConfig iis" -Verb RunAs -Wait
        }       
    }
}