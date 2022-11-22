function Add-AclEveryoneToPath($path) {
    $sid = New-Object System.Security.Principal.SecurityIdentifier ([System.Security.Principal.WellKnownSidType]::WorldSid, $null)
    $AccessRule= New-Object System.Security.AccessControl.FileSystemAccessRule($sid,"FullControl","ContainerInherit,Objectinherit","none","Allow")
    $Acl = Get-ACL $path
    $Acl.AddAccessRule($AccessRule)
    Set-Acl $path $Acl
}