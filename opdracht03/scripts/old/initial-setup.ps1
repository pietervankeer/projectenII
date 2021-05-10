
#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
$settings = Get-Content -Path settings.json | ConvertFrom-Json
if (@(Get-NetAdapter).count -eq 2) {
    $server = $settings.Servers[0]    
}
else {
    $server = $settings.Servers[1]
}
$hostname = $server.Hostname
$netAdapters = $server.Network

#------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------ 
<#
.SYNOPSIS
Write a log message in CLI

.PARAMETER string
The string you want to wrinte in the CLI

.EXAMPLE
Log "Computer is shutting down"
#>
function Log {
    param (
        $string
    )

    Write-Host $string
    
}

<#
.SYNOPSIS
Rename the network adapter and set IPv4 address

.PARAMETER name
The current name of the adapter

.PARAMETER newName
The name you want to give to the adapter

.PARAMETER ipAddress
The ip address that needs to be configured

.EXAMPLE
Update-NetAdapter("Ethernet 2", "LAN", 192.168.1.2)
#>
function Update-NetAdapter {

    param (
        $name,
        $newName,
        $ipAddress,
        $DHCP
    )
    # Fetching netInterfaces
    $netInterfaceFound = $False
    $netInterfaces = Get-NetIPConfiguration
    foreach ($interface in $netInterfaces) {
        # Did we found the interface we want to change?
        if ($interface.InterfaceAlias -eq $name) {        
            $netInterfaceFound = $True
        }
    }

    if ($netInterfaceFound -eq $False) {
        Log "Network interface $name not found!"
    }
    else {
        # rename adapter
        Rename-NetAdapter -Name $name -NewName $newName
        Log "$name adapter renamed to $newName"

        # disable ipv6
        Disable-NetAdapterBinding -Name $newName -ComponentID ms_tcpip6
        Log "IPv6 disabled for $interfaceDescr"


        if ($DHCP -eq $True) {
            # DHCP address
            # TODO enable dhcp explicit
            Log "IP address already set to receive from DHCP"
        }
        if ($DHCP -eq $False) {
            # non DHCP address
            # set IPv4 address
            New-NetIPAddress -InterfaceAlias $newName -IPAddress $ipAddress -AddressFamily IPv4
            Log "IP address set to $ipAddress for $newName adapter"
        }
        # log message
        Log "$newName adapter configured"
    }

}

<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER service
The name of the service e.g "wuauserv" for windows update service

.PARAMETER state
The state you want to service to be in (Running, Stopped, Paused)

.PARAMETER startupType
The startupType you want to service to be in (Manual, Disabled, System, Boot, Automatic)

.EXAMPLE
Update-Service("wuauserv", "Disabled", "Stopped")
#>
function Update-Service {

    param (
        $service,
        $startupType
    )
    if ($null -eq (Get-Service -Name $service)) {
        Log "Service not found"
    }
    else {   
        # update service startuptype and status
        Set-Service -Name $service -StartupType $startupType
        Log "$service Startuptype: $startupType"
    }
    
}


#------------------------------------------------------------------------------
# Initial setup
#------------------------------------------------------------------------------ 
# local admin password never expires
Set-LocalUser -Name "Administrator" -PasswordNeverExpires 1
Log "Admin password never expires!"

# set hostname
if ($env:computername -eq $hostname) {
    Log "Hostname already so to $hostname"
}
else {   
    Rename-Computer -NewName $hostname
    Log "Hostname set to $hostname"
}

# configure network adapters
if (@(Get-NetAdapter).count -eq 2) {
    Update-NetAdapter -name "Ethernet" -newName $netAdapters[0].Name -DHCP $True
    Update-NetAdapter -name "Ethernet 2" -newName $netAdapters[1].Name -DHCP $False -ipAddress $netAdapters[1].IPAdress
}
else {
    Update-NetAdapter -name "Ethernet" -newName $netAdapters[0].Name -DHCP $False -ipAddress $netAdapters[0].IPAdress
}



# Stop windows update service
Stop-Service wuauserv
Log "wuauserv stopped"

# disable windows update service
Update-Service -service "wuauserv" -startupType "Disabled"

# Restart Computer
Log "All changes will take effect after the startup"
$restart_now = Read-Host -Prompt "Would you like to restart the computer now? (y [yes] or n [no]])"

if ($restart_now -eq "y") {
    Restart-Computer
}


