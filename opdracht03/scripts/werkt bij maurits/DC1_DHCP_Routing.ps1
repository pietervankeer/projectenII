#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------

$settings = Get-Content -Path settings.json | ConvertFrom-Json


# DHCP
$domeinNaam = $settings.ADDS.DomainName
$ipServer1 = $settings.Servers[0].Network[1].IPAdress

$scopeName = $settings.DHCP.ScopeName
$scopeDescr = $settings.DHCP.ScopeDescr
$scopeStartIp = $settings.DHCP.ScopeStartIp
$scopeEndIp = $settings.DHCP.ScopeEndIp
$scopeSubMask = $settings.DHCP.ScopeSubMask
$scopeLease = $settings.DHCP.ScopeLease

$scopeIdArray = $scopeStartIp.Split(".")
$scopeId = $scopeIdArray[0]+"."+$scopeIdArray[1]+"."+$scopeIdArray[2]+"."+0

$netAdapters= $settings.Servers[0].Network


#------------------------------------------------------------------------------
# DHCP
#------------------------------------------------------------------------------

# Install DHCP
Try {

    Install-WindowsFeature DHCP -IncludeManagementTools  -ErrorAction Stop
    Write-Host "DHCP installed successfully" -ForegroundColor Green

} Catch {

    Write-Warning -Message $("Failed to install DHCP. Error: "+ $_.Exception.Message)
}

# # Configure DHCP
Try {

    # Create DHCP security groups
    netsh dhcp add securitygroups

    # Add DHCP to DC
    Add-DhcpServerInDC

    # Add IPv4 scope
    Add-DHCPServerv4Scope -Name $scopeName -StartRange $scopeStartIp -EndRange $scopeEndIp -SubnetMask $scopeSubMask -Description $scopeDescr -LeaseDuration $scopeLease -State Active

    # Authorize DHCP server
    Set-DHCPServerv4OptionValue -ScopeID $scopeId -DnsDomain $domeinNaam -DnsServer $ipServer1 -Router $ipServer1

    # Restart DHCP server
    Restart-Service dhcpserver

    # Notify Server Manager that post-install DHCP configuration is complete
    Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2

    Write-Host "DHCP configured successfully" -ForegroundColor Green

} Catch {

    Write-Warning -Message $("Failed to configure DHCP. Error: "+ $_.Exception.Message)
}


#------------------------------------------------------------------------------
# Routing
#------------------------------------------------------------------------------

# Does not work, manueel installeren 

# # Install Routing
# Try {

#     Install-windowsFeature Routing -IncludeManagementTools -Restart -ErrorAction Stop
#     Write-Host "Routing installed successfully" -ForegroundColor Green

# } Catch {

#     Write-Warning -Message $("Failed to install Routing. Error: "+ $_.Exception.Message)
# }

# # Configure Routing
# Try {

#     Install-RemoteAccess -VpnType Vpn

#     netsh routing ip nat install

#     netsh routing ip nat add interface $netAdapters[0].Name
#     netsh routing ip nat set interface $netAdapters[0].Name mode=full

#     netsh routing ip nat add interface $netAdapters[1].Name

#     netsh routing ip nat show interface


#     Write-Host "Routing configured successfully" -ForegroundColor Green

# } Catch {

#     Write-Warning -Message $("Failed to configure Routing. Error: "+ $_.Exception.Message)
# }



# Pause
Pause