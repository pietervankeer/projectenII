
#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------

$settings = Get-Content -Path settings.json | ConvertFrom-Json

$check = Get-WindowsFeature | where {($_.name -like “DNS”)}

$networkId = $settings.DNS.NetworkID
$repScope = $settings.DNS.repScope

#------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------ 

function Log {
    param (
        $string
    )

    Write-Host $string
    
}

#------------------------------------------------------------------------------
# Installation / Configuration
#------------------------------------------------------------------------------ 


If ($check.Installed -ne "True") {
        log("Install/Enable DNS services..")
        Install-WindowsFeature DNS -IncludeManagementTools
}

Log("Add reverse lookup zone..")
Add-DnsServerPrimaryZone -NetworkID $networkId -ReplicationScope $repScope

Read-Host -prompt "druk op enter om af te sluiten"