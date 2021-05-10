# Verslag: Oefening 1 Lab 3 

## Taak 1: Cable, Erase, and Reload the Routers
### Step 1: Cable a network that is similar to the one in the Topology Diagram.
1. Selecteer en sleep de nodige apparatuur op het werkblad in packet tracer. (Switches zijn van het type 2960 en routers van het type 1841.)
2. Voeg aan elke router een HWIC-2T module toevoor de seriële poorten.
2. Verbind de toestellen zoals aangegeven op de topology. (De routers zijn onderling verbonden via Serial DCE, alle andere toestellen via Copper Straigth-Through.)

### Step 2: Clear the configuration on each router.
Voer op elk van de 3 routers volgende reeks commando's uit:
```
> Router> enable
> Router# erase startup-config
> Router# reload
```
Antwoord `no` als gevraagd wordt om wijzigingen op te slaan.


## Taak 2: Perform Basic Router Configuration
Herhaal onderstaande stappen voor de andere twee routers, maar pas de hostname aan.
### Stap 1: Use global configuration commands.
```
> Router# configure terminal
> Router(config)# hostname R1

> R1(config)# no ip domain-lookup

> R1(config)# enable secret class
```

### Stap 2: Configure the console and virtual terminal line passwords on each of the routers.
```
> R1(config)# line console 0
> R1(config-line)# password cisco
> R1(config-line)# login

> R1(config-line)# line vty 0
> R1(config-line)# password cisco
> R1(config-line)# login
```

### Stap 3: Add the logging synchronous command to the console and virtual terminal lines.
```
> R1(config)# line console 0
> R1(config-line)# logging synchronous

> R1(config-line)# line vty 0
> R1(config-line)# logging synchronous
```

### Stap 4: Add the exec-timeout command to the console and virtual terminal lines.
```
> R1(config)# line console 0
> R1(config-line)# exec-timeout 0 0

> R1(config-line)# line vty 0
> R1(config-line)# exec-timeout 0 0
```

## Taak 3: Interpreting Debug Output
### Stap 1: On R1 from privileged EXEC mode, enter the debug ip routing command.
```
> R1# debug ip routing
```

### Stap 2: Enter interface configuration mode for R1's LAN interface.
```
> R1(config)# interface fa0/0
> R1(config-if)# ip address 172.16.3.1 255.255.255.0
```

### Stap 3: Enter the command necessary to install the route in the routing table.
```
> R1(config-if)# no shutdown
```

### Stap 4: Enter the command to verify that the new route is now in the routing table.
```
> R1# show ip route
```

### Stap 5: Enter interface configuration mode for R1's WAN interface connected to R2.
```
> R1(config)# interface s0/0/0
> R1(config-if)# ip address 172.16.2.1 255.255.255.0
```

### Stap 6: Enter the clock rate command on R1.
```
> R1(config-if)# clock rate 64000
```

### Stap 7: Enter the command necessary to ensure that the interface is fully configured.
```
> R1(config-if)# no shutdown
```

### Stap 8: If possible, establish a separate terminal session by consoling into R2 from another workstation. Doing this allows you to observe the debug output on R1 when you make changes on R2. You can also turn on debug ip routing on R2.

```
> R2# debug ip routing
> R2# configure terminal
> R2(config)# int s0/0/0
> R2(config-if)# ip address 172.16.2.2 255.255.255.0
```

### Stap 9: Enter the command necessary to ensure that the interface is fully configured.
```
> R2(config-if)# no shutdown
```

### Stap 10: Enter the command to verify that the new route is now in the routing table for R1 and R2.
```
> R1# show ip route
```
```
> R2# show ip route
```

### Stap 11: Turn off debugging on both routers using either no debug ip routing or simply, undebug all.
```
> R1# no debug ip routing
```
```
> R2# no debug ip routing
```


## Taak 4: Finish Configuring Router Interfaces
### Stap 1: Configure Remaining R2 Interfaces.
```
> R2# configure terminal
> R2(config)# interface fa0/0
> R2(config-if)# ip address 172.16.1.1  255.255.255.0
> R2(config-if)# no shutdown

> R2(config)#interface s0/0/1
> R2(config-if)# ip address 192.168.1.2 255.255.255.0
> R2(config-if)# clock rate 64000
> R2(config-if)# no shutdown
```

### Stap 2: Configure R3 Interfaces.
```
> R3# configure terminal
> R3(config)# interface fa0/0
> R3(config-if)# ip address 192.168.2.1 255.255.255.0
> R3(config-if)# no shutdown

> R3(config)#interface s0/0/1
> R3(config-if)# ip address 192.168.1.1 255.255.255.0
> R3(config-if)# no shutdown
```

## Taak 5: Configure IP Addressing on the Host PCs
### Stap 1: Configure the host PC1.
PC1 klikken > Desktop > IP Configuration
IP Adres    | Subnetmask    | Default Gateway
----------- | ------------- | ---------------
172.16.3.10 | 255.255.255.0 | 172.16.3.1

### Stap 2: Configure the host PC2.
PC2 klikken > Desktop > IP Configuration
IP Adres    | Subnetmask    | Default Gateway
----------- | ------------- | ---------------
172.16.1.10 | 255.255.255.0 | 172.16.1.1

### Stap 3: Configure the host PC3.
PC3 klikken > Desktop > IP Configuration
IP Adres     | Subnetmask    | Default Gateway
------------ | ------------- | ---------------
192.168.2.10 | 255.255.255.0 | 192.168.2.1


## Taak 6: Test and Verify the Configurations
/


## Taak 7: Gather Information
### Stap 1: Check status of interfaces
```
> R1# show ip interface brief
```

### Stap 2: View the routing table information for all three routers
```
> R1# show ip route
```


## Taak 8: Configure a Static Route Using a Next-Hop Address
### Stap 1: On the R3 router, configure a static route to the 172.16.1.0 network using the Serial 0/0/1 interface of R2 as the next-hop address.
```
> R3(config)# ip route 172.16.1.0 255.255.255.0 192.168.1.2
```

### Stap 2: View the routing table to verify the new static route entry.
```
> R3# show ip route
```

### Stap 3: Use ping to check connectivity between the host PC3 and the host PC2.
PC3 klikken > Desktop > Command Prompt
```
C:\> ping 172.16.1.10
```

### Stap 4: On the R2 router, configure a static route to reach the 192.168.2.0 network.
```
> R2(config)# ip route 192.168.2.0 255.255.255.0 192.168.1.1
```

### Stap 5: View the routing table to verify the new static route entry.
```
> R2# show ip route
```

### Stap 6: Use ping to check connectivity between the host PC3 and the host PC2.
PC3 klikken > Desktop > Command Prompt
```
C:\> ping 172.16.1.10
```


## Taak 9: Configure a Static Route Using an Exit Interface
### Stap 1: On the R3 router, configure a static route.
```
> R3(config)# ip route 172.16.2.0 255.255.255.0 Serial0/0/1
```

### Stap 2: View the routing table to verify the new static route entry.
```
> R3# show ip route
```
Use the `show running config` command to verify the static routes that are currently configured on
R3.
```
> R3# show running-config
```

### Stap 3: On the R2 router, configure a static route.
```
> R2(config)# ip route 172.16.3.0 255.255.255.0 Serial0/0/0
```

### Stap 4: View the routing table to verify the new static route entry.
```
> R2# show ip route
```

### Stap 5: Use ping to check connectivity between the host PC2 and PC1.
PC2 klikken > Desktop > Command Prompt
```
C:\> ping 172.16.3.10
```
Zou moeten falen aangezien R1 geen return route heeft naar het netwerk 172.16.1.0


## Taak 10: Configure a Default Static Route
### Stap 1: Configure the R1 router with a default route.
```
> R1(config)# ip route 0.0.0.0 0.0.0.0 172.16.2.2
```

### Stap 2: View the routing table to verify the new static route entry.
```
> R1# show ip route
```

### Stap 3: Use ping to check connectivity between the host PC2 and PC1.
PC2 klikken > Desktop > Command Prompt
```
C:\> ping 172.16.3.10
```

Pingen is nog niet mogelijk vanuit PC3 omdat er geen route vastgelegd is op R3 naar het netwerk 172.16.3.0

## Taak 11: Configure a Summary Static Route
### Stap 1: Configure the summary static route on the R3 router.
```
> R3(config)# ip route 172.16.0.0 255.255.252.0 192.168.1.2
```

### Stap 2: Verify that the summary route is installed in the routing table.
```
> R3# show ip route
```

### Stap 3: Remove static routes on R3.
```
R3(config)# no ip route 172.16.1.0 255.255.255.0 192.168.1.2
R3(config)# no ip route 172.16.2.0 255.255.255.0 Serial0/0/1
```

### Stap 4: Verify that the routes are no longer in the routing table.
```
R3# show ip route
```

### Stap 5: Use ping to check connectivity between the host PC3 and PC1.
PC3 klikken > Desktop > Command Prompt
```
C:\> ping 172.16.3.10
```