# Checklist: hoe reset je eventuele achtergebleven instellingen op een Cisco router/switch?

## Switch

### Onbekend admin-wachtwoord

- [ ] Un-plug alle kabels uit de switch.
- [ ] Houd de reset-knop in voor 15 tot 20 seconden.
- [ ] Als alle LED lichtjes oplichten, laat de reset-knop los.

De switch is nu gereset.

### Bekend admin-wachtwoord

De configuratie van een switch zit opgeslagen in de Startup-configuration.
Echter moet men eerst mogelijke vlans gaan verwijderen, deze zijn opgeslagen in vlan.dat
Om achtergebleven configuratie te verwijderen gaan we dus de startup-config verwijderen.
Nadat de startup-config is verwijdert gaan we het commando `reload` gebruiken om de startup-config in te laden

- [ ] Commando: `enable`
- [ ] Commando: `delete vlan.dat`
- [ ] Commando: `erase startup-config`
- [ ] Commando: `reload`


## Router

### Onbekend admin-wachtwoord

- [ ] Schakel de router uit, maar laat de stekker inzitten.
- [ ] Zoek de reset-knop en houd deze in terwijl u de router terug opzet.
- [ ] Laat na 10 seconden de reset-knop los.
- [ ] Laat de routen booten en schakel hem daarna terug uit.

### Bekend admin-wachtwoord

De configuratie van een router zit opgeslagen in de Startup-configuration.
Om achtergebleven configuratie te verwijderen gaan we dus de startup-config verwijderen.
Nadat de startup-config is verwijdert gaan we het commando `reload` gebruiken om de startup-config in te laden

- [ ] Commando: `enable`
- [ ] Commando: `erase startup-config`
- [ ] Commando: `reload`