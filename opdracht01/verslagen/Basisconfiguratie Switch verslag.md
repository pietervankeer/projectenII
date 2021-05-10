# Verslag Basisconfiguratie Switch

De packet tracer oefening over het configureren van een switch heb ik als volgt opgelost.
Ik ben begonnen bij Switch 1, deze heb ik met een console kabel verbonden met User-01 door de consolepoorten op beide toestellen. Vervolgens heb ik via de Terminal applicatie van de Desktop van User-01 verbinding gemaakt met de CLI van Switch 1. 
Vervolgens ben ik in terminal volgende zaken beginnen invoeren:
-	enable 

-	hostname ASw-1

-	configure terminal 

    -> hierdoor kon ik andere zaken gaan aanpassen aan de terminal

-	line vty 0 
	- Password R4Xe3 
    
    -> basis paswoord instellen dat voor alles geldt

-	enable secret C4aJa 

    -> paswoord om in de enable modus te geraken

-	service password-encryption 

    -> zo worden alle paswoorden geencrypteerd zodat ze niet af te lezen zijn uit de configs

-	banner motd 'warning, unauthorised access strictly forbidden.'

-	interface VLAN1 
-	ip address 10.10.10.100 255.255.255.0
-	no shutdown

-	copy running-config startup-config 	
    
    -> zo worden de dingen die ik net heb aangepast wel degelijk opgeslagen in het NVRAM, zo is deze configuratie niet kwijt als de switch herstart

Voor de 2de switch heb ik dezelfde procedure gevolgd, enkel met natuurlijk de juiste naam voor switch 2 en het juiste ip-address voor VLAN1.
Na het configureren van de 2 switches heb ik tot slot de 2 computers hun juiste ip-address en subnetmask gegeven.

