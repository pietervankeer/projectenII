#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------

$settings = Get-Content -Path settings.json | ConvertFrom-Json


# ADDS
$domeinnaam = $settings.ADDS.DomainName
$domeinNetBiosNaam = $settings.ADDS.DomainNetBiosName

$password = $settings.Admin.Password


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

    Install-ADDSForest -DomainName $domeinnaam -SafeModeAdministratorPassword (ConvertTo-SecureString -String $password -AsPlainText -Force) -DomainNetbiosName $domeinNetBiosNaam -InstallDns -Force -ErrorAction Stop
    Write-Host "Active Directory Domain Services have been configured successfully" -ForegroundColor Green

}
Catch {

    Write-Warning -Message $("Failed to configure Active Directory Domain Services. Error: "+ $_.Exception.Message)
}

# Pause
Pause