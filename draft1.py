from random import randrange
from fractions import Fraction
from decimal import Decimal

primes = [2, 3/2, 5/4, 7/4]
ref = 100

def get_unique_set(array):
    # returns a unique set of three from array
    # returns an array
    array_copy = array[:]
    choice1 = array_copy.pop(randrange(0, len(array_copy)))
    choice2 = array_copy.pop(randrange(0, len(array_copy)))
    choice3 = array_copy.pop(randrange(0, len(array_copy)))
    pair = [choice1, choice2, choice3]
    #pair.sort()
    return pair

prime_set = get_unique_set(primes)
print("PRIME SET:", prime_set)

"""
square1:
3   4
1   2

square2:
7   8
5   6
"""
# add octave conditions based on instrument range ( /2 or /4), needs to be consistent for both axes?

def build_square1(ref, prime_set):
    """
    ref = freqency int or float in Hz
    primes = list of 3 primes (first 2 will be used)
    """
    freq1 = ref
    freq2 = ref * prime_set[0]
    freq3 = ref * prime_set[1]
    freq4 = freq3 * prime_set[0]
    square1 = [freq1, freq2, freq3, freq4]
    return square1

def build_square2(square1, prime_set):
    """
    square1 = list of 4 freqs
    primes = list of 3 primes (last one will be used)
    """
    prime = prime_set[-1]
    square2 = []

    for point in square1:
        direction = randrange(0, 2)
        if direction == 1:
            new_point = point * prime
        else:
            new_point = point / prime
        square2.append(new_point)

    return square2

def get_all_ratios(square1, square2):
    for i in range(len(square1)):
        point1 = square1[i]
        print("THIS SQUARE:")
        for j in range(i+1, len(square1)):
            point2 = square1[j]
            dividend = point1 / point2
            ratio = Fraction(dividend).limit_denominator(1000)
            print(ratio)
        print("\tSECOND SQUARE:")
        for point3 in square2:
            dividend = point1 / point3
            ratio = Fraction(dividend).limit_denominator(1000)
            print("\t", ratio)


square1 = build_square1(ref, prime_set)
square2 = build_square2(square1, prime_set)

get_all_ratios(square1, square2)
exit()

print(square1[2:])
print(square1[0:2])
print()
print(square2[2:])
print(square2[0:2])



# get 1 new prime for 3rd dimension? or multiple?
