# PowerShell module for CapaInstaller #
This module is for managing CapaInstaller from PowerShell.

The module is not a full implementation of all the exposed functionality from the official Capa SDK, but only the subset of functionality I have had to use in my projects.

The following functions are currently available:


    Add-CapaAddUnitToPackage
    Add-CapaUnitToGroup
    Backup-CapaPackage
    Clear-CapaPackage
    Clone-CapaPackage
    Get-CapaDefaultManagementPointRegistry
    Get-CapaGroup
    Get-CapaLatestPackageVersionNumber
    Get-CapaPackagePath
    Get-CapaPackages
    Get-CapaUnit
    Get-CapaUnitPackages
    Increment-Version
    New-CapaGroup
    Rebuild-CapaPackage
    Remove-CapaGroup
    Remove-CapaUnitFromGroup
    Replace-CapaPackage
    Restart-CapaAgent
    Set-CapaPackageFolder
    Set-CapaPackageSchedule
    Set-CapaUnitPackageStatus
    Set-UnitPackageStatus
    Update-CapaPackageCisVersion
    
Not all of these cmdlets can be mapped 1:1 to a Capa SDK function, some are helper functions to extend functionality of the Capa SDK.

Here is an example of a potential usecase, to clone a package from an existing package, increment its version and add new files to the installation

Input variables:

    $PackageName   = 'MyPackage"
    $UnitType  = 'Computer'
    $UnitName  = 'MyServer'
    $CMPFolderPath = '\\CapaServer\CMP\ComputerJobs\'
    $KitCompressFolder = '\\CapaServer\CMP\Resources\Tools\KitCompress'
    $NewPackagePath= "Path to the new files to be added to the package"
    $Status= 'Waiting'

Get the current version of the package:

    $PackageLatestVersionNumber = Get-CapaPackages -PackageType Computer -Name $PackageName | Get-CapaLatestPackageVersionNumber

We increment the package version based on the current version, we can increment Major, Minor versions

    $PackageNewVersionNumber = Increment-Version -Minor -VersionNumber $PackageLatestVersionNumber

We clone the current package, creating a new package in the Capa tree

    Clone-CapaPackage -PackageName $PackageName -PackageVersion $PackageLatestVersionNumber -PackageType 1 -NewPackageVersion $PackageNewVersionNumber

Since the Capa Clone Package, does not change the .cis file version numbers, this function automatically makes the changes to the script .cis file in the new package

    Update-CapaPackageCisVersion -CMPFolderPath $CMPFolderPath -PackageName $PackageName -PackageVersion $PackageNewVersionNumber   -Verbose
Removes everything from the /kit folder of the new Package

    Clear-CapaPackage -PackageName $PackageName -CMPFolderPath $CMPFolderPath -PackageVersion $PackageNewVersionNumber -Verbose

Copies all the application files/folders into the new Package folder

    Replace-CapaPackage -PackageName $PackageName  -PackageVersion $PackageNewVersionNumber -CMPFolderPath $CMPFolderPath -NewPackagePath $NewPackagePath

Configures the Package Schedule, so the packages is actually enabled in Capa Installer

    Set-CapaPackageSchedule -PackageName $PackageName -PackageVersion $PackageNewVersionNumber -PackageType Computer -ScheduleRecurrence Once
Connect the Computer to the Package so that the new package can be deployed

    Add-CapaAddUnitToPackage -UnitName $UnitName -UnitType Computer -PackageName $PackageName -PackageVersion $PackageNewVersionNumber -PackageType 1

In order to move the new package to the same path as the package it is replacing, we need to get the path of the current Capa Package.

    $OldPackagePath = Get-CapaPackagePath -PackageName $PackageName -PackageVersion $PackageLatestVersionNumber -PackageType Computer
Now we set the Capa Package Folder path of the new Package to be the same as the old package

    Set-CapaPackageFolder -PackageName $PackageName -PackageVersion $PackageNewVersionNumber -PackageType Computer -FolderStructure $OldPackagePath  -ChangeLogText 'AutomatedDeploy'
Rebuild the Capa installer kit, so that the new files will be packaged for deployment

    Rebuild-CapaPackage -PackageName $PackageName -CMPFolderPath $CMPFolderPath -PackageVersion $PackageNewVersionNumber -KitCompressFolder $KitCompressFolder

We will set the Package Status to Waiting, so that the next time the agent runs, the package is marked for installation

    Set-UnitPackageStatus -UnitName $UnitName -PackageName $PackageName -PackageVersion $PackageNewVersionNumber -UnitType $UnitType -Status $Status -PackagetType 1

In order to force the installation of the package immediately, we will restart the agent

    Restart-CapaAgent -UnitName $UnitName -UnitType 1

The module gets expanded as I need to automate the deployment of packages even more, let me know if this is useful for you, or if you have any request for features, or better yet make the changes yourself and do a PR  :)

The functions needs some more documentation, I am working on that as much as time permits