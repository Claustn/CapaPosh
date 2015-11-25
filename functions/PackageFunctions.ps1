function Set-CapaPackageFolder
{
    [CmdletBinding()]
    param
    (
        [String]$PackageName,
        [String]$PackageVersion,
        [ValidateSet('Computer', 'User')]
        [String]$PackageType,
        [String]$FolderStructure,
        [String]$ChangeLogText = "Moved by Automated Build script"
    )
    
    Begin
    {
        $CapaCom = New-Object -ComObject CapaInstaller.SDK
    }
    Process
    {
        $CapaCom.SetPackageFolder($PackageName,$PackageVersion,$PackageType,$FolderStructure,$ChangeLogText)                
    }
    End
    {
        $CapaCom = $null
        Remove-Variable -Name CapaCom
    }
}

function Get-CapaPackages
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Computer', 'User')]
        [string]
        $PackageType,
        [Parameter(Mandatory = $false)]
        [String]
        $Name = '*'
    )
    
    Begin
    {
        $CapaCom = New-Object -ComObject CapaInstaller.SDK
        $CapaApps = @()
    }
    Process
    {
        $Software = $CapaCom.GetPackages("$PackageType")
        $softwarelist = $Software -split "`r`n"
        $softwarelist | ForEach-Object -Process {
            $SplitLine = ($_).split('|')
            
            $CapaApps += [pscustomobject][ordered] @{
                PackageName               = $SplitLine[0]
                PackageVersion            = $SplitLine[1]
                PackageType               = $SplitLine[2]
                PackageDisplayName        = $SplitLine[3]
                PackageIsMandatory        = $SplitLine[4]
                PackageScheduleId         = $SplitLine[5]
                PackageDescription        = $SplitLine[6]
                PackageGUID               = $SplitLine[7]
                PackageID                 = $SplitLine[8]
                PackageIsInteractive      = $SplitLine[9]
                PackageDependendPackageID = $SplitLine[10]
                PackageIsInventoryPackage = $SplitLine[11]
                PackageCollectMode        = $SplitLine[12]
                PackagePriority           = $SplitLine[13]
                PackageServerDeploy       = $SplitLine[14]
            }
        }
        
    }
    End
    {
        Return $CapaApps | Where-Object -FilterScript {
            $_.PackageName -like "$Name"
        }
        $CapaCom = $null
        Remove-Variable -Name CapaCom
    }
}


function Get-CapaPackagePath
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName = $true)]
        $PackageName,
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        $PackageVersion ,
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Computer', 'User')]
        $PackageType,
        [Switch]$Append
    )
    
    Begin
    {
        $CapaCom = New-Object -ComObject CapaInstaller.SDK
    }
    Process
    {
        if ($Append)
        {
            $input | Add-Member -MemberType NoteProperty -Name PackageCMSPath -Value $($CapaCom.GetPackageFolder($PackageName, $PackageVersion, $PackageType)) -PassThru
        }
        Else
        {
            $CapaCom.GetPackageFolder($PackageName, $PackageVersion, $PackageType)
        }
        
        
    }
    End
    {
        $CapaCom = $null
        Remove-Variable -Name CapaCom
    }
}

function Clone-CapaPackage
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]$PackageName,
        [Parameter(Mandatory = $true)]
        [String]$PackageVersion,
        [Parameter(Mandatory = $true)]
        [ValidateSet('1', '2')]
        [string]$PackageType,
        [Parameter(Mandatory = $true)]
        [String]$NewPackageVersion
    )
	
    Begin
    {
        $CapaCom = New-Object -ComObject CapaInstaller.SDK
        If ($PackageVersion -notmatch '^v')
        {$PackageVersion = "v$PackageVersion"}
        If ($NewPackageVersion -notmatch '^v')
        {$NewPackageVersion = "v$NewPackageVersion"}
    }
    Process
    {
		
        $CapaCom.ClonePackage($PackageName, $PackageVersion, $PackageType, $NewPackageVersion)
    }
    End
    {
        $CapaCom = $null
        Remove-Variable -Name CapaCom
    }
}