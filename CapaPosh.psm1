<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2015 v4.2.97
	 Created on:   	25-11-2015 10:06
	 Created by:   	 
	 Organization: 	 
	 Filename:     	CapaPosh.psm1
	-------------------------------------------------------------------------
	 Module Name: CapaPosh
	===========================================================================
#>

# Load functions
$functions = Get-ChildItem -Path "$PSScriptRoot\functions" -Recurse -Include *.ps1
foreach ($function in $functions)
{
	. $function.FullName
}

# Load internal functions
$internals = Get-ChildItem -Path "$PSScriptRoot\Internal" -Recurse -Include *.ps1
foreach ($internal in $internals)
{
	. $internal.FullName
}

#Export-ModuleMember Get-CapaDefaultManagementPointRegistry,
#					Replace-CapaPackage,
#					Rebuild-CapaPackage,
#					Backup-CapaPackage,
#					Get-CapaLatestPackageVersionNumber,
#					Set-CapaPackageFolder,
#					Get-CapaPackages,
#					Get-CapaPackagePath,
#					Add-CapaAddUnitToPackage,
#					Set-CapaPackageSchedule,
#					Get-CapaUnitPackages,
#					Set-UnitPackageStatus,
#					Restart-CapaAgent