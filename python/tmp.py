#!/usr/bin/env python3

x = 123
y = 456
d = x & y
e = x | y
f = x << 2
g = y >> 2
h = ~x
i = ~y

for wire in 'defghixy':
    print('wire %s: %d' % (wire, eval(wire)))

f = x // 2**2
g = y * 2**2

for wire in 'fg':
    print('wire %s\': %d' % (wire, eval(wire)))
