# **Lab 2: Building a simple network**  

### **Part 1: Set up the network topology(ethernet only)**

*Step 1: Power on the devices*  

1. Automatisch opgestart

*Step 2: Connect the two switches*  

1. Connections
2. Copper Cross-Over
3. Selecteer Switch
4. Selecteer F0/1
5. Selecteer andere switch
6. Selecteer F0/1

*Step 3: Connect the PC's to their respective switches*  

**Switch 1:**  
1. Connections
2. Copper Straight-Through
3. Selecteer Switch 1
4. F0/6
5. Selecteer PC-A
6. Selecteer FastEthernet0

**Switch 2:**  
1. Connections
2. Copper Straight-Through
3. Selecteer Switch 2
4. Selecteer F0/18
5. Selecteer PC-B
6. Selecteer FastEthernet0

### **Part 2: Configure PC hosts**

*Step 1: Configure static IP address information on the PC's*  

1. Selecteer PC
2. Desktop
3. IP Configuration
4. Herhaal voor andere PC

*Step 2: Verify PC settings and connectivity*

1. Selecteer PC
2. Desktop
3. Command Prompt
4. ipconfig /all
5. Herhaal voor andere PC

### **Part 3: Configure and verify basic switch settings**  

*Step 1: Console into switch*  

1. Connections
2. Console
3. Selecteer PC
4. Selecteer rs323
5. Selecteer switch
6. Console
7. Selecteer PC
8. Desktop
9. Terminal

*Step 2: Enter priviliged EXEC mode*

1. enable/en  

*Step 3: Enter configuration mode*

1. configure terminal

*Step 4: Give the switch a name*  

1. hostname S1

*Step 5: Prevent unwanted DNS lookup*

1. no ip domain lookup

*Step 6: Enter  local passwords*  

1. enable secret class
2. line con 0
3. password cisco
4. login
5. exit

*Step 7: Enter a login MOTD banner*  

1. banner motd "
2. Unauthorized access is strictly prohibited and prosecuted to the full extend of the law. "
3. exit

*Step 8: Save the configuration*  

1. copy running-config startup-config
2. Press [Enter]

*Step 9: Display the current configuration*

1. show running-config

*Step 10: Display the IOS version and other useful switch information*  

1. show version

*Step 11: Display the status of the connected interfaces on the switch*

1. show ip interface brief

*Step 12: Repeat steps 1 to 12 to configure switch S2*

1. Alleen hostname veranderen naar S2

### **Appendix A: Initializing and reloading a switch**  

*Step 1: Connect to the switch*  

1. enable/en

*Step 2: Determine if there have been any virtual local-area networks (VLANs) created*  

1. show flash

*Step 3: Delete the VLAN file*  

1. delete vlan.dat
2. Press [Enter] twice

*Step 4: Erase the startup configuration file*  

1. erase startup-config
2. press [Enter]

*Step 5: Reload the switch*  

1. reload
2. press [Enter]