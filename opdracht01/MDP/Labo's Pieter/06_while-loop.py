
while True:

    x = input("Wollah geef nummer: ")
    y=1
    if x == 'q' or x == 'quit':
        print("Wollah afbreken die handel")
        break
    x=int(x)
    while True:
        print(y)
        y=y+1
        if y>x:
            break
