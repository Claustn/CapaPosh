# PowerShell module for CapaInstaller #
This module is for managing CapaInstaller from PowerShell.

The module is not a full implementation of all the exposed functionality from the official Capa SDK, but only the subset of functionality I have had to use in my projects.

The following functions are currently available:


> *Add-CapaAddUnitToPackage
>  Add-CapaUnitToGroup
> Backup-CapaPackage
> Clear-CapaPackage
> Clone-CapaPackage
> Get-CapaDefaultManagementPointRegistry
> Get-CapaGroup
> Get-CapaLatestPackageVersionNumber
> Get-CapaPackagePath
> Get-CapaPackages
> Get-CapaUnit
> Get-CapaUnitPackages
> Increment-Version
> New-CapaGroup
> Rebuild-CapaPackage
> Remove-CapaGroup
> Remove-CapaUnitFromGroup
> Replace-CapaPackage
> Restart-CapaAgent
> Set-CapaPackageFolder
> Set-CapaPackageSchedule
> Set-CapaUnitPackageStatus
> Set-UnitPackageStatus
> Update-CapaPackageCisVersion*

Not all of these cmdlets can be mapped 1:1 to a Capa SDK function, some are helper functions to extend functionality of the Capa SDK.