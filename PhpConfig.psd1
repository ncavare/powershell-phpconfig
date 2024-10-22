@{
    RootModule = 'PhpConfig.psm1'
    ModuleVersion = '1.4.1'
    GUID = 'd044165f-756f-43c9-bea1-400c46a14006'
    Author = 'Nicolas Cavare'
    Description = 'A PowerShell module to configure PHP'
    PowerShellVersion = '5.0'
    FunctionsToExport = 'Install-PhpFull', 'Remove-Php', 'Set-PhpExtension','Set-PhpMode','Set-PhpLimit','Set-PhpSwitcher','Set-PhpIIS','Show-PhpInfo','Show-PhpConfig'
    RequiredModules = @(
        @{"ModuleName"="PhpManager";"ModuleVersion"="1.26.2"}
        @{"ModuleName"="SetEnv";"ModuleVersion"="1.0.2"}
        @{"ModuleName"="PSMenu";"ModuleVersion"="0.1.9"}
    )
    CmdletsToExport = @()
    AliasesToExport = @()
    PrivateData = @{
        PSData = @{
            Tags = 'php'
            ProjectUri = 'https://github.com/ncavare/powershell-phpconfig'
            ReleaseNotes = 'fix iis activityTimeout'
        }
   }
}

