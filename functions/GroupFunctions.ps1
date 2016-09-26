#requires -Version 3.0
function New-CapaGroup
{
  [CmdletBinding()]
  [OutputType([boolean])]
  param
  (
    [Parameter(Mandatory = $true)]
    [String]$GroupName,
    [Parameter(Mandatory = $true)]
    [ValidateSet('Calendar', 'Department', 'Static')]
    [String]$GroupType,
    [Parameter(Mandatory = $true)]
    [ValidateSet('Computer', 'User')]
    [String]$UnitType
  )
	
	
  Begin
  {
    $CapaCom = New-Object -ComObject CapaInstaller.SDK
  }
  Process
  {
    $CapaCom.CreateGroup("$GroupName", "$GroupType", "$UnitType")
  }
  End
  {
    $CapaCom = $null
    Remove-Variable -Name CapaCom
  }
}

function Remove-CapaGroup
{
  [CmdletBinding()]
  [OutputType([boolean])]
  param
  (
    [Parameter(Mandatory = $true)]
    [String]$GroupName,
    [Parameter(Mandatory = $true)]
    [ValidateSet('Calendar', 'Department', 'Reinstall', 'Security', 'Static', 'Dynamic_SQL', 'Dynamic_ADSI')]
    [String]$GroupType,
    [Parameter(Mandatory = $true)]
    [ValidateSet('Computer', 'User')]
    [String]$UnitType
  )
	
	
  Begin
  {
    $CapaCom = New-Object -ComObject CapaInstaller.SDK
  }
  Process
  {
    $CapaCom.DeleteGroup("$GroupName", "$GroupType", "$UnitType")
  }
  End
  {
    $CapaCom = $null
    Remove-Variable -Name CapaCom
  }
}

function Get-CapaGroup
{
  [CmdletBinding()]
  [OutputType([pscustomobject])]
  param
  (
    [Parameter(Mandatory=$False)][ValidateSet('Calendar', 'Department', 'Reinstall', 'Security', 'Static', 'Dynamic_SQL', 'Dynamic_ADSI')]
    [String]$GroupType = ''  
  )
	
	
  Begin
  {
    $CapaCom = New-Object -ComObject CapaInstaller.SDK
    $CapaGroups = @()
  }
  Process
  {
    

    $Groups = $CapaCom.GetGroups("$GroupType")
    $Groupslist = $Groups -split "`r`n"
    $Groupslist | ForEach-Object -Process {
      $SplitLine = ($_).split('|')
			
      Try
      {
        $CapaGroups += [pscustomobject][ordered] @{
          GroupName        = $SplitLine[0]
          GroupType        = $SplitLine[1]
          GroupTypeID      = $SplitLine[2]
          GroupDescription = $SplitLine[3]
          GroupGUID        = $SplitLine[4]
          GroupID          = $SplitLine[5]
        }
      }
      Catch
      {
        Write-Warning -Message "An error occured for computer: $($SplitLine[0]) "
      }
    }
  }
  End
  {
    
    $CapaCom = $null
    Remove-Variable -Name CapaCom
    Return $CapaGroups
  }
}


if ($(Get-CapaGroup -GroupType Static | Select -ExpandProperty GroupName) -contains 'Skade') {"hurra"}


Get-CapaGroup  | where GroupName -Match 'early'

Invoke-Sqlcmd -Database CapaDB -ServerInstance apsql2008ny -Query 'select * from UNITGRP'