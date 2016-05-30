char = 0
floor = 0
first = True

with open('input.txt') as f:
    for x in f.read().strip():
        char += 1

        if x == '(':
            floor += 1
        else:
            floor -= 1

        if floor < 0 and first == True:
            print char
            first = False

