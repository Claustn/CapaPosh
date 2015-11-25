function Add-CapaAddUnitToPackage
{
    [CmdletBinding()]
    param
    (
        [String]$UnitName,
        [ValidateSet('Computer', 'User')]
        [string]$UnitType,
        [String]$PackageName,
        [String]$PackageVersion,
        [ValidateSet('1', '2')]
        [String]$PackageType
    )
    
    Begin
    {
        $CapaCom = New-Object -ComObject CapaInstaller.SDK
    }
    Process
    {
        
        $CapaCom.AddUnitToPackage($UnitName,$UnitType,$PackageName,$PackageVersion,$PackageType)
    }
    End
    {
        $CapaCom = $null
        Remove-Variable -Name CapaCom
    }
}


function Set-CapaPackageSchedule
{
    <#
            .SYNOPSIS
            A brief description of the Set-CapaSchedule function.
    
            .DESCRIPTION
            A detailed description of the Set-CapaSchedule function.
    
            .PARAMETER PackageName
            The name of the package
    
            .PARAMETER PackageVersion
            Package version
    
            .PARAMETER PackageType
            Type of package
    
            .PARAMETER ScheduleStart
            The Schedule start date in the format  "yyyy-MM-dd HH:mm" eg. "2015-04-15 12:05"
        
            yyyy - Year with century.
            MM - Numeric month with a leading zero.
            dd - Numeric day of the month with a leading zero.
            HH - 24 Hour clock with leading zero.
            mm - Minutes with leading zero.
    
            .PARAMETER ScheduleEnd
            The Schedule start date in the format  "yyyy-MM-dd HH:mm" eg. "2015-04-15 12:05". If no end date is wanted leave the string empty. e.g. ""
        
            yyyy - Year with century.
            MM - Numeric month with a leading zero.
            dd - Numeric day of the month with a leading zero.
            HH - 24 Hour clock with leading zero.
            mm - Minutes with leading zero.
    
            .PARAMETER ScheduleIntervalBegin
            The Schedule Interval begin time in the format  HH:mm" eg. "06:00". If left empty it is set to 00:00
        
            HH - 24 Hour clock with leading zero.
            mm - Minutes with leading zero.
    
            .PARAMETER ScheduleIntervalEnd
            The Schedule Interval end time in the format  HH:mm" eg. "12:00". If left empty it is set to 00:00
        
            HH - 24 Hour clock with leading zero.
            mm - Minutes with leading zero.
    
            .PARAMETER ScheduleRecurrence
            The Schedule Recurrence for the schedule.
        
            Possible values:
        
            "Once"
            "PeriodicalDaily", use the variable ScheduleRecurrencePattern detail this recurrence
            "PeriodicalWeekly", use the variable ScheduleRecurrencePattern detail this recurrence
            "Always"
    
            .PARAMETER ScheduleRecurrencePattern
            Is used to further detail the Schedule Recurrence when set to PeriodicalDaily or PeriodicalWeekly
        
            Possible values:
        
            ScheduleRecurrence = "PeriodicalDaily"
            ScheduleRecurrencePattern  = "RecurEveryWeekDay" sets the recurrence pattern to run every weekday
            ScheduleRecurrencePattern  = "" Sets the recurrence pattern to recur every day including weekend days.
            ScheduleRecurrence = "PeriodicalWeekly"
            ScheduleRecurrencePattern   = "1,3,5" Will set the schedule pattern to run
    
            .EXAMPLE
            PS C:\> Set-CapaSchedule -PackageName $value1 -PackageVersion $value2
    
            .NOTES
            Additional information about the function.
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(HelpMessage = 'The name of the package')]
        $PackageName,
        [Parameter(HelpMessage = 'Package version')]
        $PackageVersion,
        [Parameter(HelpMessage = 'Type of package')]
        [ValidateSet('Computer', 'User')]
        $PackageType,
        [Parameter(HelpMessage = 'The Schedule start date in the format  "yyyy-MM-dd HH:mm" eg. "2015-04-15 12:05"')]
        [ValidatePattern('[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (2[0-3]|[01][0-9]):[0-5][0-9]')]
        $ScheduleStart = '',
        [Parameter(HelpMessage = 'The Schedule start date in the format  "yyyy-MM-dd HH:mm" eg. "2015-04-15 12:05". If no end date is wanted leave the string empty. e.g. ""')]
        [ValidatePattern('[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (2[0-3]|[01][0-9]):[0-5][0-9]')]
        $ScheduleEnd = '',
        [Parameter(HelpMessage = 'The Schedule Interval begin time in the format  HH:mm" eg. "06:00". If left empty it is set to 00:00')]
        [ValidatePattern('([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]')]
        $ScheduleIntervalBegin = '',
        [Parameter(HelpMessage = 'The Schedule Interval end time in the format  HH:mm" eg. "12:00". If left empty it is set to 00:00')]
        [ValidatePattern('([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]')]
        $ScheduleIntervalEnd = '',
        [Parameter(HelpMessage = 'The Schedule Recurrence for the schedule.')]
        [ValidateSet('Once', 'PeriodicalDaily', 'PeriodicalWeekly', 'Always')]
        $ScheduleRecurrence,
        [Parameter(HelpMessage = 'Is used to further detail the Schedule Recurrence when set to PeriodicalDaily or PeriodicalWeekly')]
        $ScheduleRecurrencePattern = ''
    )
    
    Begin
    {
        $CapaCom = New-Object -ComObject CapaInstaller.SDK
    }
    Process
    {
        
        $CapaCom.SetPackageSchedule($PackageName, $PackageVersion, $PackageType, $ScheduleStart, $ScheduleEnd , $ScheduleIntervalBegin, $ScheduleIntervalEnd, $ScheduleRecurrence, $ScheduleRecurrencePattern)
    }
    End
    {
        $CapaCom = $null
        Remove-Variable -Name CapaCom
    }
}


function Get-CapaUnitPackages
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $UnitName,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Computer', 'User')]
        [string]
        $UnitType
    )
    
    Begin
    {
        $CapaCom = New-Object -ComObject CapaInstaller.SDK
        $CapaApps = @()
    }
    Process
    {
        $Software = $CapaCom.GetUnitPackages("$UnitName", "$UnitType")
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
        Return $CapaApps
        $CapaCom = $null
        Remove-Variable -Name CapaCom
    }
}

function Set-UnitPackageStatus
{
    [CmdletBinding()]
    [OutputType([bool])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $UnitName,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Computer', 'User')]
        [string]
        $UnitType,
        [Parameter(Mandatory = $true)]
        [string]
        $PackageName,
        [Parameter(Mandatory = $true)]
        [string]
        $PackageVersion,
        [Parameter(Mandatory = $true)]
        [ValidateSet('1', '2')]
        [string]
        $PackagetType,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Installing', 'Waiting', 'Failed', 'Cancelled', 'Cancel', 'Installed', 'Uninstall', 'Post', 'Disabled', 'Not Compliant', 'Advertised')]
        [string]
        $Status
    )
    
    
    Begin
    {
        $CapaCom = New-Object -ComObject CapaInstaller.SDK
    }
    Process
    {
        $CapaCom.SetUnitPackageStatus("$UnitName", "$UnitType", "$PackageName", "$PackageVersion", "$PackagetType", "$Status")
    }
    End
    {
        $CapaCom = $null
        Remove-Variable -Name CapaCom
    }
}

function Restart-CapaAgent
{
    [CmdletBinding()]
    [OutputType([bool])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $UnitName,
        [Parameter(Mandatory = $true)]
        [ValidateSet('1', '2')]
        [string]
        $UnitType
    )
    
    Begin
    {
        $CapaCom = New-Object -ComObject CapaInstaller.SDK
    }
    Process
    {
        $CapaCom.RestartAgent("$UnitName", "$UnitType")
    }
    End
    {
        $CapaCom = $null
        Remove-Variable -Name CapaCom
    }
}