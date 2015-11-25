<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2015 v4.2.97
	 Created on:   	25-11-2015 10:06
	 Created by:   	 
	 Organization: 	 
	 Filename:     	CapaPosh.psd1
	 -------------------------------------------------------------------------
	 Module Manifest
	-------------------------------------------------------------------------
	 Module Name: CapaPosh
	===========================================================================
#>

@{

# Script module or binary module file associated with this manifest
ModuleToProcess = 'CapaPosh.psm1'

# Version number of this module.
ModuleVersion = '1.0.0.0'

# ID used to uniquely identify this module
GUID = 'da5e4404-95ba-4786-ae4f-da235cfdea6b'

# Author of this module
Author = 'Claus Thude Nielsen '

# Company or vendor of this module
CompanyName = 'Automate-IT '

# Copyright statement for this module
Copyright = '(c) 2015. All rights reserved.'

# Description of the functionality provided by this module
Description = 'PowerShell module to manage the CapaInstaller SDK from PowerShell '

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '2.0'

# Name of the Windows PowerShell host required by this module
PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
PowerShellHostVersion = ''

# Minimum version of the .NET Framework required by this module
DotNetFrameworkVersion = '2.0'

# Minimum version of the common language runtime (CLR) required by this module
CLRVersion = '2.0.50727'

# Processor architecture (None, X86, Amd64, IA64) required by this module
ProcessorArchitecture = 'None'

# Modules that must be imported into the global environment prior to importing
# this module
RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to
# importing this module
ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @()

# Modules to import as nested modules of the module specified in
# ModuleToProcess
NestedModules = @()

# Functions to export from this module
FunctionsToExport = '*'

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
ModuleList = @()

# List of all files packaged with this module	
	FileList = @(
	'functions\_Utilities.ps1'
	'functions\ContainerFunctions.ps1'
	'functions\GroupFunctions.ps1'
	'functions\InventoryFunctions.ps1'
	'functions\OSDeploymentFunctions.ps1'
	'functions\PackageFunctions.ps1'
	'functions\SystemSDKFunctions.ps1'
	'functions\UnitFunctions.ps1'
	'functions\WSUSFunctions.ps1'
	)
	

# Private data to pass to the module specified in ModuleToProcess	
	# Private data to pass to the module specified in ModuleToProcess	
	PrivateData = @{
		PSData = @{
			# The web address of this module's project or support homepage.
			ProjectUri = 'https://github.com/Claustn/CapaPosh'
			
			# The web address of this module's license. Points to a page that's embeddable and linkable.
			LicenseUri = 'http://opensource.org/licenses/MIT'
		}
	}
	
}






