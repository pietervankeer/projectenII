# opening file
file = open("devices.txt","a")

while True:
    newItem = input("Give new device: ")
    
    if newItem == "exit":
        print("All done")
        break
    file.write(newItem + "\n")
file.close()
