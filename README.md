[![PowerShell Gallery Download Count](https://img.shields.io/powershellgallery/dt/PhpConfig?label=downloads%20from%20PSGallery)](https://www.powershellgallery.com/packages/PhpConfig)
## Introduction
A PowerShell module that implements functions to install PHP with interactive menu
I use phpmanager, more info here : https://github.com/mlocati/powershell-phpmanager 

## Installation

```powershell
Install-Module -Name PhpConfig
```
## Usage with interactive menu

```powershell
Show-PhpConfig
```

## Usage of  Install-PhpFull
```powershell
Install-PhpFull -version 8.1-nts-x86 -ext common,com,odbc,mysql,imagick,sqlsrv,opcache,xdebug -mode dev
```

## Usage of  Set-PhpExtension
```powershell
Set-PhpIIS -ext common,com,odbc,mysql,imagick,sqlsrv,opcache,xdebug -path C:\php\php-8.1-nts-x86
```

## Usage of  Set-PhpMode
```powershell
Set-PhpIIS -mode dev -path C:\php\php-8.1-nts-x86
Set-PhpIIS -mode prod -path C:\php\php-8.1-nts-x86
```

## Usage of  Set-PhpLimit
```powershell
Set-PhpLimit -limit classic -path C:\php\php-8.1-nts-x86
Set-PhpLimit -limit high -path C:\php\php-8.1-nts-x86
```

## Usage of  Set-PhpSwitcher
```powershell
Set-PhpSwitcher
```

## Usage of  Switch-Php
```powershell
Switch-Php 7.4
Switch-Php 8.1
```

## Usage of  Set-PhpIIS
```powershell
Set-PhpIIS -site mysite.local -path C:\php\php-8.1-nts-x86
```

