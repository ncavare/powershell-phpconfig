
function Show-PhpConfig() {
    [CmdletBinding()]
    Param($chose_action)
    
    write-host  
    if ($chose_action -eq $null){
        write-host "-----------------PHP CONFIG $($MyInvocation.MyCommand.ScriptBlock.Module.Version)---------------------"    
        $chose  = Write-Menu -items @{1='Install php';2='Configure php extension';3='Configure mode dev/prod';4='Remove php';5='Install php switcher';6='Switch php version';7='Configure iis'} -prompt 'choose an action'
        switch ($chose){
            1{ $chose_action="install"}
            2{ $chose_action="configure"}
            3{ $chose_action="modedevprod"}
            4{ $chose_action="remove"}
            5{ $chose_action="installswitcher"}
            6{ $chose_action="switchphp"}
            7{ $chose_action="iis"}
        }
    }

    if ($chose_action -eq "install"){  
        $chose  = Write-Menu -items @{1='PHP 7.4';2='PHP 8.0';3='PHP 8.1'} -prompt 'choose a version'
        switch ($chose){
            1{ $chose_version="7.4";}
            2{ $chose_version="8.0";}
            3{ $chose_version="8.1";}
        }
        $chose = Write-Menu -items @{1='Non Thread Safe';2='Thread Safe'} -prompt 'choose a version'
        switch ($chose){
            1{ $chose_tread='nts' }
            2{ $chose_tread='ts' }     	
        }
        $chose = Write-Menu -items @{1='x86';2='x64'} -prompt 'choose a version'
        switch ($chose){
            1{ $chose_archi='x86'; }
            2{ $chose_archi='x64'; }     	
        }         
        $ext  = 'common','com','odbc','mysql','imagick','sqlsrv','opcache'
        if (Write-SmallMenu "Install extension xdebug (y/n) ?"){ $ext += 'xdebug'}
        if (Write-SmallMenu "Mode DEV display_errors=on html_errors=on (y/n)?"){ $mode = 'dev' }else{ $mode = 'prod' }

        $version = "$chose_version-$chose_tread-$chose_archi"

        $path = Install-PhpFull -version $version -ext $ext -limit 'high' -mode $mode
        Show-PhpInfo $path      
    }

    if ($chose_action -eq "configure"){         
        $path  = Write-Menu -items (Get-ListPhp) -prompt 'choose an install php' -returnitem     
        if (Write-SmallMenu "Install extension xdebug (y/n) ?"){ $ext = 'imagick','sqlsrv','xdebug','opcache'} else{ $ext = 'imagick','sqlsrv','opcache'}

        Set-PhpExtension -ext  $ext  -path  $path
        Show-PhpInfo $path
    }

    if ($chose_action -eq "modedevprod"){ 
        $path  = Write-Menu -items (Get-ListPhp) -prompt 'choose an install php' -returnitem
        if (Write-SmallMenu "Mode DEV display_errors=on html_errors=on (y/n)?"){ $mode = 'dev' }else{ $mode = 'prod' }  

        Set-PhpMode -mode $mode -path $path
    }      

    if ($chose_action -eq "remove"){
        $path  = Write-Menu -items (Get-ListPhp) -prompt 'choose an install php' -returnitem

        Remove-Php -path $path     
    }

    if ($chose_action -eq "installswitcher"){       
        Set-PhpSwitcher       
    }

    if ($chose_action -eq "switchphp"){
        $chose  = Write-Menu -items ((Get-PhpSwitcher).targets)  -prompt 'choose an install php'

        Switch-php -name $chose -force
        Show-PhpInfo
    }

    if ($chose_action -eq "iis"){
        if (Test-Administrator){
            $site  = Write-Menu -items (Get-ListIIS) -prompt 'choose a web site' -returnitem
            $path  = Write-Menu -items (Get-ListPhp) -prompt 'choose an install php' -returnitem    
            Set-PhpIIS -site $site -path $path
        }else{
            Start-Process -FilePath 'powershell.exe' -ArgumentList "-Command Show-PhpConfig iis" -Verb RunAs -Wait
        }       
    }
}