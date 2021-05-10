#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------

$settings = Get-Content -Path settings.json | ConvertFrom-Json

# Network
$netAdapters= $settings.Servers[1].Network

$hostname = $settings.Servers[1].Hostname
$DCIPaddress = $settings.Servers[0].Network[1].IPAdress

#------------------------------------------------------------------------------
# Hostname
#------------------------------------------------------------------------------

# Set hostname
Rename-Computer -NewName $hostname
Write-Host "Hostname changed successfully" -ForegroundColor Green

# Install all updates?

#------------------------------------------------------------------------------
# Network Adapters
#------------------------------------------------------------------------------

function Update-NetAdapter($name, $newName, $ipv4Address, $dhcp) {

    Try {
        # Adapter exists?
        $tmp = Get-NetAdapter -Name $name -ErrorAction Stop 

        # Rename adapter
        Rename-NetAdapter -Name $name -NewName $newName

        # Disable IPv6
        Disable-NetAdapterBinding -Name $newName -ComponentID ms_tcpip6

        # Set static IP
        if (-Not [string]::IsNullOrEmpty($ipv4Address)) {
            New-NetIPAddress -InterfaceAlias $newName -IPAddress $ipv4Address -AddressFamily IPv4 -PrefixLength "24" -DefaultGateway $DCIPaddress | Out-Null
        }

        # DHCP
        if (-Not $dhcp) {
            Set-NetIPInterface -InterfaceAlias $newName -Dhcp Disabled
        }

        # Set DNS server
        Set-DnsClientServerAddress -InterfaceAlias $newName -ServerAddresses ($DCIPaddress)

        Write-Host "Network Adapter " $name " updated successfully" -ForegroundColor Green

    } Catch {

        Write-Warning -Message $("Failed to Update Network Adapter " + $name  + ". Error: "+ $_.Exception.Message)
    }
}

# LAN
Update-NetAdapter -name "Ethernet" -newName $netAdapters[0].Name -ipv4Address $netAdapters[0].IPAdress -dhcp $False



# Restart computer
Write-Host "All changes will take effect after the startup"
Pause
Restart-Computer