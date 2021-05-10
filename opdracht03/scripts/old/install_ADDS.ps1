
#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
$settings = Get-Content -Path settings.json | ConvertFrom-Json
$domeinnaam = $settings.ADDS.DomainName
$domeinNetBiosNaam = $settings.ADDS.DomainNetBiosName
$hostnameDC = "GROEP02DC"
$hostnameAut = "GROEP02AUT"
$hostname = (Get-Content env:computername)
$ADSitename = "Gent"

#------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------ 
<#
.SYNOPSIS
Write a log message in CLI

.PARAMETER string
The string you want to write in the CLI

.EXAMPLE
Log "Computer is shutting down"
#>
function Log {
    param (
        $string
    )

    Write-Host $string
    
}


#------------------------------------------------------------------------------
# ADDS
#------------------------------------------------------------------------------ 
if ($hostname -eq $hostnameAut) {
    # Dns server instellen op Groep02DC
    Get-DnsServer -ComputerName $hostnameDC | Set-DnsServer

    # member server toevoegen aan domein
    $cred = Get-Credential -Credential $domeinnaam\Administrator
    Add-Computer -DomainName $domeinnaam -Credential $cred
}

Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
Log "Installatie ADDS voltooid"

# Promoot to DC
if ($hostname -eq $hostnameDC) {
    Install-ADDSForest -DomainName $domeinnaam -DomainMode WinThreshold -DomainNetbiosName $domeinNetBiosNaam -ForestMode WinThreshold -InstallDns -NoRebootOnCompletion
}

if ($hostname -eq $hostnameAut) {
    Install-ADDSDomainController -DomainName $domeinnaam -SiteName $ADSitename -InstallDns -NoRebootOnCompletion -ReplicationSourceDC Groep02DC
}

# Restart Computer
Log "All changes will take effect after the startup"
$restart_now = Read-Host -Prompt "Would you like to restart the computer now? (y [yes] or n [no])"

if ($restart_now -eq "y") {
    Restart-Computer
}