#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------

$settings = Get-Content -Path settings.json | ConvertFrom-Json


# ADDS
$domeinnaam = $settings.ADDS.DomainName
$domeinNetBiosNaam = $settings.ADDS.DomainNetBiosName
$ADSitename = "Gent"

$password = $settings.Admin.Password
$DCServer = $settings.Servers[0].Hostname
$fullDomainName = $DCServer + "." + $domeinnaam
$credentailUsername = $domeinNetBiosNaam + "\" + "Administrator"

#------------------------------------------------------------------------------
# AD DS
#------------------------------------------------------------------------------

# Install Active Directory Services
Try {

    Install-WindowsFeature AD-Domain-Services -IncludeManagementTools -Restart -ErrorAction Stop
    Write-Host "Active Directory Domain Services installed successfully" -ForegroundColor Green

} Catch {

    Write-Warning -Message $("Failed to install Active Directory Domain Services. Error: "+ $_.Exception.Message)
}

# Configure Active Directory
Try {

    Install-ADDSDomainController -DomainName $domeinnaam -SafeModeAdministratorPassword (ConvertTo-SecureString -String $password -AsPlainText -Force) -InstallDns -ReplicationSourceDC $fullDomainName -NoRebootOnCompletion -Credential (Get-Credential $credentailUsername) -Force -ErrorAction Stop
    Write-Host "Active Directory Domain Services have been configured successfully" -ForegroundColor Green

}
Catch {

    Write-Warning -Message $("Failed to configure Active Directory Domain Services. Error: "+ $_.Exception.Message)
}


# Restart computer
Write-Host "All changes will take effect after the startup"
Pause
Restart-Computer