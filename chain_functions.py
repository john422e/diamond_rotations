from random import randrange, choice
from fractions import Fraction
from decimal import Decimal

def get_unique_set(array, set_length):
    # returns a unique set of three from array
    # returns an array
    if set_length >= len(array):
        print("ERROR: please select a set_length smaller than array size")
        return

    array_copy = array[:]
    set = []
    for i in range(set_length):
        choice = array_copy.pop(randrange(0, len(array_copy)))
        set.append(choice)

    return set

def get_ratio(f1, f2, limit=1000):
    """
    returns the ratio of two values, with a denominator limit
    """
    dividend = f1 / f2
    ratio = Fraction(dividend).limit_denominator(limit)
    return ratio

def get_sequential_sidebands(chain):
    """
    calculates positive and negative sidebands of each frequency in a sequence
    with its two neighbors (first and last in sequence are also neighbors)
    [
    [[freq1, freq2], [sum, diff] (add ratios too?)], ...
    ]
    """
    elements = []
    for i, freq in enumerate(chain):
        # get neighbor, for last element that will be first element
        if i == (len(chain) - 1):
            neighbor = chain[0]
        else:
            neighbor = chain[i+1]
        # get positive sideband (summation tone)
        pos_sideband = freq + neighbor
        # get negative sideband (difference tone)
        neg_sideband = max([freq, neighbor]) - min([freq, neighbor])
        # get ratios of sidebands to each ref freq
        pos_ratio1 = get_ratio(pos_sideband, freq)
        pos_ratio2 = get_ratio(pos_sideband, neighbor)
        neg_ratio1 = get_ratio(neg_sideband, freq)
        neg_ratio2 = get_ratio(neg_sideband, neighbor)
        # bundle ratios
        pos_ratios = [pos_ratio1, pos_ratio2]
        neg_ratios = [neg_ratio1, neg_ratio2]
        # bundle sidebands with ratios
        sidebands = [[pos_sideband, pos_ratios], [neg_sideband, neg_ratios]]
        # bundle freqs with ratio
        freqs = [freq, neighbor, get_ratio(freq, neighbor)]
        # bundle entry
        entry = [freqs, sidebands]
        # add to list
        elements.append(entry)
    return elements


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

def build_rectangle(ref, prime_set):
    """
    builds a 6 point rectangle (two adjacent squares)
    since prime set order is not ordered, rectangle is always the same orientation

    6   5   4

    1   2   3
    """
    freq1 = ref
    freq2 = freq1 * prime_set[0]
    freq3 = freq2 * prime_set[0]
    freq6 = freq1 * prime_set[1]
    freq5 = freq6 * prime_set[1]
    freq4 = freq5 * prime_set[1]
    rectangle = [freq1, freq2, freq3, freq4, freq5, freq6]
    return rectangle

def build_diamond(ref, prime_set):
    """
    builds a 6 point diamond
    since prime set order is not ordered, rectangle is always the same orientation
        5
    6       4

    1       3
        2
    """
    freq1 = ref
    freq2 = (freq1 * prime_set[0]) / prime_set[1]
    freq3 = freq2 * prime_set[0] * prime_set[1]
    freq6 = freq1 * prime_set[1]
    freq5 = freq6 * prime_set[0] * prime_set[1]
    freq4 = freq3 * prime_set[1]
    diamond = [freq1, freq2, freq3, freq4, freq5, freq6]
    return diamond

def build_random_chain(ref, chain_length):
    chain = [ref]

    for i in range(chain_length-1):
        # get last chain element
        node1 = chain[i]
        node2_valid = False
        iteration = 0

        while not node2_valid:
            print("iteration:", iteration)
            iteration += 1
            # get random interval and direction
            interval = choice(prime_set)
            direction = choice(['up', 'down'])
            if direction == 'up':
                node2 = node1 * interval
            else:
                node2 = node1 / interval

            if node2 in chain:
                print("already selected, trying again", node2)
            elif node2 < hz_min:
                print("too low, trying again", node2)
            elif node2 > hz_max:
                print("too high, trying again", node2)
            else:
                print("Valid choice:", node2)
                node2_valid = True

        chain.append(node2)
    return chain

def get_ratio(n1, n2, limit=1000):
    """
    returns the ratio (as a Fraction) of two numbers
    """
    dividend = n1 / n2
    ratio = Fraction(dividend).limit_denominator(limit)
    return ratio

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
