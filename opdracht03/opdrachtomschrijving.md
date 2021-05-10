# Opdracht 3: Microsoft Deployment Toolkit

## Opdrachtomschrijving

Voor een kantoornetwerk (Windows omgeving) wens je de uitrol van software op de werkstations (clients) te automatiseren. Je wenst ook om de webserver van het bedrijf te automatiseren. Binnen een Windows omgeving kan je dit met "Microsoft Deployment Toolkit (MDT)" op een efficiënte manier uitvoeren.

Gebruik Virtualbox om deze installaties te doen. Maak geen gebruik van Vagrant. Dit gaat u redelijk veel problemen geven om dit op te zetten. Gebruik de toolkit MDT, en daar waar nodig gebruik je PowerShell om bepaalde roll-outs te doen van de server en eventueel ook de clients. Elke installatie moet gebeuren via PXE boot.

Installeer volgende opstelling, alle installaties zijn met Windows Server 2019, en voor de client Windows 10. Vooraleer tot configuratie over te gaan, voer alle updates uit op de verschillende toestellen.

- 1 Domain Controller
    - naam domein is `CoronaPrj.local`
    - hostnaam: `GroepxxDC` met `xx` je groepnummer
- 1 Member Server lid van bovenstaand domein.
    - hostnaam: `GroepxxAut`
- Clientsystemen (toegevoegd aan bovenstaand domein)
    - hostnamen `GroepxxCly` met `y` een oplopend nummer

Installeer binnen het domein volgende zaken:

- Rollen AD – DNS – DHCP (op latere DC)
- Rollen WSUS op latere Member Server
- Software: MDT op latere Member Server

**WSUS Windows Server Update Services:**

- Systeemupdates voor Clients voorzien
    - Voor clientupdates voorzie de Nederlandstalige updates en de Engelstalige update
- Systeemupdates voor Servers
    - Voor serverupdates voorzie je enkel de Engelstalige updates

**MDT – Microsoft Deployment Toolkit**

Gebruik MDT, terug te vinden op <https://www.microsoft.com/en-us/download/details.aspx?id=54259> om volgende software pakketten automatisch op de clients te installeren:

Client Image:

- Windows 10
    - Clean installatie voor nieuwe toestellen
- Adobe Reader
    - Moet geïnstalleerd worden op nieuwe en bestaande toestellen, die de software nog niet hebben
    - Bij nieuwe installaties kan je het integreren in uw image van de Windows Client
- Java
    - Moet geïnstalleerd worden op nieuwe en bestaande toestellen.
    - Bij nieuwe installaties kan je het integreren in uw image van de Windows Client
- Officesuite (bv. LibreOffice)

Server Image:

Zorg dat je een Windows Server 2019 automatisch kan installeren aan de hand van MDT. Voorzie in uw MDT verschillende tasksequences, dit wil zeggen dat je verschillende versies kan deployen. Hieronder enkele voorbeelden

- Tasksequence 1:
    - Windows 2019 clean install
- Tasksequence 2:
    - Windows 2019 met volgende onderdelen
        - ASP.NET
        - IIS
- Tasksequence 3:
    - Microsoft SQL Server.

Meeer info beschikbaar op deze link: <https://docs.microsoft.com/nl-be/configmgr/mdt/index>

## Deliverables

- Demo tijdens de contactmomenten van de proof-of-concept
    - Automatische installatie Windows Server en Windows 10
- Op Github:
    - Lastenboek
    - Alle achtergrondinformatie die jullie verzameld hebben om met de opdracht aan de slag te kunnen gaan
    - Gedetailleerde technische handleidingen gericht naar andere teamleden over installatieprocedures en de gebruikte scripts
    - Testplannen en testrapporten
