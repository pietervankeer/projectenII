# Cheat Sheet IOS Commando's

### 1. Basic Config (Switch & Router)

1. **Assign name**
    ```
    > Switch(config)# hostname <name>
    ```

2. **Secure EXEC mode**
    ```
    > Switch(config)# line console 0
    > Switch(config-line)# password <password>
    > Switch(config-line)# login
    ```

3. **Secure VTY lines** (telnet, ssh)
    ```
    > Switch(config)# line vty 0 [15]					    *max 16 vty's (0-15)
    > Switch(config-line)# password <password>
    > Switch(config-line)# login
    ```

    1. **SSH**
        ```
        > Switch(config)# ip domain-name <domain-name>
        > Switch(config)# crypto key generate rsa
        > How many bits in the modulus [512]: 1024 [Enter]

        > Switch(config)# username <username> secret <password>

        > Switch(config)# line vty 0 [15]
        > Switch(config-line)# transport input ssh
        > Switch(config-line)# login local
        > Switch(config-line)# exit
        
        > Switch(config)# ip ssh version 2
        > Switch(config)# exit
        ```    

4. **Secure privilege EXEC mode**
    ```
    > Switch(config)# enable secret <secret_password>
    ```

5. **Secure all passwords**
    ```
    > Switch(config)# service password-encryption
    ```

6. **Provide legal notification**
    ```
    > Switch(config)# banner motd "This is a secure system. Authorized Access Only!"
    ```

7. **Save configuration to NVRAM**
    ```
    > Switch# copy running-config startup-config
    > Destination filename [startup-config]? [Enter]
    ```

### 2. IPv4 interface
```
> Router(config)# interface <interface>
> Router(config-if)# ip address <ipv4-address> <subnet_mask>
> Router(config-if)# no shutdown
> Router(config-if)# description <... connection to ...>  
```

### 3. IPv6 interface
1. **Enable IPv6**
    ```
    > Router(config)# ipv6 unicast-routing
    ```

2. **Add IPv6 interface**
    ```
    > Router(config)# interface <interface>
    > Router(config-if)# ipv6 address <ipv6-address>/<subnet mask>
    > Router(config-if)# no shutdown
    ```

### 4. Default gateway
```
> Switch(config)# ip default-gateway <ipv4-address>
```

### 5. Routing
1. **Static Route Using a Next-Hop Address**
```
> Router(config)# ip route <network-address> <subnet_mask> <next-hop-ipv4-address>
```
2. **Static Route Using an Exit Interface**
```
> Router(config)# ip route <network-address> <subnet_mask> <exit-interface>
```

3. **Default Static Route**
```
> Router(config)# ip route 0.0.0.0 0.0.0.0 <ipv4-address | interface>
```

4. **Summary Static Route**
```
> Router(config)# ip route <common-network-address> <subnet_mask> <ipv4-address | interface>
```


### 5. Overviews
1. **Running configuration**
    ```
    > Router# show running-config
    ```
2. **Routing table**
    ```
    > Router# show ip route
    ```
3. **IPv4 interfaces**
    ```
    > Router# show ip interface brief
    ```

3. **IPv6 interfaces**
    ```
    > Router# show ipv6 interface brief
    ```