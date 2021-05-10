# Verslag: Oefening 1 Lab 3 

# TODO
Oopdracht-01-lab3.pdf:

- p.3 vraag beantwoorden
- p.4 vraag beantwoorden

## Deel 1: De topologie opzetten

1. Selecteer en sleep de nodige apparatuur op het werkblad in packet tracer.
2. Selecteer de copper straigth-through kabel en verbindt de apparatuur via de nodige poorten/interfaces

## Deel 2: Apparaten configureren

### Stap 1

a.
  - PC-A --> Desktop --> Ip configuration
  - Als ipv4 adress, subnetmask, default gateway neem de je corresponderende adressen in de adresserings tabel

b.
  - PC-B --> Desktop --> Ip configuration
  - Als ipv4 adress, subnetmask, default gateway neem de je corresponderende adressen in de adresserings tabel

c. Pingen kan je doen door het commando `ping <ip address>`

### Stap 2

a. Commando: `enable` 

b. Commando: `config t` of 
de lange versie `configure terminal`

c. Commando: `hostname R1`

d. Commando: `no ip domain-lookup`

e. Commando: `enable secret class`

f.
  - Commando: `line con 0`
  - Commando: `password cisco`
  - Commando: `login`
  - Commando: `exit`

g.
  - Commando: `line vty 0 15`
  - Commando: `password cisco`
  - Commando: `login`
  - Commando: `exit`

h. commando: `service password-encryption`

i. Commando: `banner motd "no unauthorized access or you will be killed"`

j.  
  - interface g0/0
    - Commando: `config t` of de lange versie `configure terminal`
    - Commando: `interface g0/0`
    - Commando: `ip address 192.168.0.1 255.255.255.0`
    - Commando: `no shutdown`
    - Commando: `exit`
  - interface g0/1
    - Commando: `config t` of de lange versie `configure terminal`
    - Commando: `interface g0/1`
    - Commando: `ip address 192.168.1.1 255.255.255.0`
    - Commando: `no shutdown`
    - Commando: `exit`

k.  
  - interface g0/0
    - Commando: `interface g0/0`
    - Commando: `PC-B`
    - Commando: `exit`
  - interface g0/1
    - Commando: `interface g0/1`
    - Commando: `S1`
    - Commando: `exit`

i. Commando `copy run start` in enable mode
> kopieer de running config naar de starting config

m. Commando: `clock set 18:47:00 Feb 18 2021`