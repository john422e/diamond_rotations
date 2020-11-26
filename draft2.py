import sys
from random import randrange, choice
import FMfunctions as fm
import chain_functions as cf

def cast_to_int(n):
    return int(n)
"""
if len(sys.argv) > 1:
    partials = sys.argv[1:]
    partials = list(map(cast_to_int, partials))

else:
    print("Input partial list, separated by spaces:")
    partials = list(input())
    while ' ' in partials:
        partials.remove(' ')
    partials = list(map(cast_to_int, list(partials)))

print("PARTIALS:", partials)
"""

fundamental = 110 # A2
primes = [2, 3/2, 5/4, 7/4]
hz_min = 100
hz_max = 1000
#
prime_set = cf.get_unique_set(primes, 2)
print("PRIME INTERVALS:", prime_set)

# get random freq to start chain, needs to be high enough that first step won't
# go too low
start = randrange(200, 250)

chain = cf.build_diamond(220, prime_set)

print()
print()
print("Chain:", chain)
print()
sidebands = cf.get_sequential_sidebands(chain)
for pair in sidebands:
    print("Freqs:", pair[0])
    print("\tSidebands:", pair[1])
    print()

print()
#calculate all ratiosan
#fm.get_sidebands(c, m, order_max=order_max, display=True)
