 function Set-PhpLimit() {
    [CmdletBinding()]
    Param($limit,$path)

        if($limit -eq 'high'){
            write-host "Configure memory_limit post_max_size upload_max_filesize max_file_uploads"    
            Set-PhpIniKey max_execution_time 300 -path $path
            Set-PhpIniKey memory_limit 256M -path $path
            Set-PhpIniKey post_max_size 100M -path $path
            Set-PhpIniKey upload_max_filesize 100M -path $path
            Set-PhpIniKey max_file_uploads 200 -path $path
        }

        if($limit -eq 'classic'){
            write-host "Configure memory_limit post_max_size upload_max_filesize max_file_uploads"    
            Set-PhpIniKey max_execution_time 30 -path $path
            Set-PhpIniKey memory_limit 128M -path $path
            Set-PhpIniKey post_max_size 8M -path $path
            Set-PhpIniKey upload_max_filesize 2M -path $path
            Set-PhpIniKey max_file_uploads 20 -path $path
        }
 }