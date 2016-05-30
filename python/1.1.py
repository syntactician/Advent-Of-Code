count = 0

with open('input.txt') as f:
    for x in f.read().strip():
        if x == '(':
            count += 1
        else:
            count -= 1

    print count
