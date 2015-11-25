function Get-CapaDefaultManagementPointRegistry
{
    [CmdletBinding()]
    [OutputType([string])]
    param ()
    
    (Get-ItemProperty -Path HKLM:\SOFTWARE\CapaSystems\CapaInstaller\CDM\ciCMS).CMPGuid
}


function Replace-CapaPackage
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $PackageName,
        [Parameter(Mandatory = $true)]
        [String]
        $CMPFolderPath,
        [Parameter(Mandatory = $true)]
        [String]
        $PackageVersion,
        [Parameter(Mandatory = $true)]
        [String]
        $NewPackagePath
    )
    
    Get-ChildItem $NewPackagePath -Recurse | ForEach-Object -Process {
        Set-ItemProperty -Path $($_.FullName) -Name IsReadOnly -Value $false 
    }   
    Copy-Item -Path "$NewPackagePath\*" -Destination "$CMPFolderPath\$PackageName\$PackageVersion\kit\" -Recurse -Force
}

function Rebuild-CapaPackage
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $PackageName,
        [Parameter(Mandatory = $true)]
        [String]
        $CMPFolderPath,
        [Parameter(Mandatory = $true)]
        [string]
        $PackageVersion,
        [Parameter(Mandatory = $true)]
        [string]
        $KitCompressFolder
    )
    
    $psi = New-Object -TypeName System.Diagnostics.ProcessStartInfo
    $psi.CreateNoWindow = $true
    $psi.UseShellExecute = $true
    $psi.FileName = "$KitCompressFolder\KitCompress.exe"
    $psi.Arguments = @("`"$CMPFolderPath$PackageName\$PackageVersion\kit`"", "`"$CMPFolderPath$PackageName\$PackageVersion\zip`"")
    $process = New-Object -TypeName System.Diagnostics.Process
    $process.StartInfo = $psi
    [void]$process.Start()
    $process.WaitForExit()
    
    
    #   $KitCompress = "$KitCompressFolder\KitCompress.exe"
    #    Write-Verbose $KitCompress
    #    $KitPackagePath = "$CMPFolderPath$PackageName\$PackageVersion\kit"
    #    Write-Verbose $KitPackagePath
    #    & $KitCompress $KitPackagePath
}

function Backup-CapaPackage
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $PackageName,
        [Parameter(Mandatory = $true)]
        [String]
        $CMPFolderPath,
        [Parameter(Mandatory = $true)]
        [string]
        $PackageVersion
    )
    
    
    $BackUpFolderName = (Get-Date).Tostring('yyyy-MM-ddTHH_mm_ss')
    Write-Verbose -Message "BackUp Folder Name: $BackUpFolderName"
    Write-Verbose -Message "Creating BackUp Folder: $CMPFolderPath\$PackageName\$BackUpFolderName"
    $BackUpFolder = New-Item -ItemType Directory -Path "$CMPFolderPath\$PackageName\$BackUpFolderName"
    Write-Verbose -Message "Copying Package files From : $CMPFolderPath\$PackageName\$PackageVersion\kit\*.* To: $($BackUpFolder.Fullname)"
    Move-Item -Path "$CMPFolderPath\$PackageName\$PackageVersion\kit\*.*" -Destination $($BackUpFolder.Fullname) -Force
}


function Get-CapaLatestPackageVersionNumber
{
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
        [Parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName = $true)]
        [string]$PackageName
    )
    
    begin
    {
        $versions = @()
    }
    process
    {
        $versions += [version]($($input.PackageVersion -replace 'v', ''))
    }
    end
    {
        ($versions |
            Sort-Object |
        Select-Object -Last 1).ToString()
    }
}
