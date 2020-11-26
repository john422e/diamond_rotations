"""
in all cases:
c = carrier frequency in Hz
m = modulator frequency in Hz
"""

from fractions import Fraction

def get_fundamental(c, m, display=False):
    frac = Fraction(c, m)
    n1 = frac.numerator
    n2 = frac.denominator
    f1 = c/n1
    f2 = m/n2
    if f1 != f2:
        print("ERROR: fundamentals not equal")
        return

    if display:
        print("Carrier:", c, "Mod:", m)
        print("N1:", n1, "N2:", n2)
        print("f1:", f1, "f2:", f2)

    return f1

def get_sidebands(c, m, order_max=1, display=False):
    frac = Fraction(c, m)
    n1 = frac.numerator
    n2 = frac.denominator
    f1 = c/n1
    f2 = m/n2
    if f1 != f2:
        print("ERROR: fundamentals not equal")
        return

    if display:
        print("Carrier:", c, "Mod:", m)
        print("N1:", n1, "N2:", n2)
        print("f1:", f1, "f2:", f2)

    spectrum = []
    partials = []

    for n in range(1, order_max+1):
        """
        n = order of side freqs
        k = harmonic number
        """
        print(n)
        sum_freq = c + (n * m)
        sum_partial = n1 + (n * n2)
        diff_freq = c - (n * m)
        diff_partial = n1 - (n * n2)
        print("sum:", sum_freq, sum_partial, "diff:", diff_freq, diff_partial)
        spectrum.append(sum_freq)
        spectrum.append(diff_freq)
        partials.append(sum_partial)
        partials.append(diff_partial)

    spectrum.sort()
    partials.sort()
    print(spectrum)
    print(partials)

"""
unique_funds = []

fundamental = 100
max_partial = 16
max = fundamental * max_partial + 1

for i in range(fundamental, max, fundamental):
    for j in range(i, max, fundamental):
        if i != j:
            fund = get_fundamental(i, j)
            if fund not in unique_funds:
                unique_funds.append(fund)

unique_funds.sort()
print(unique_funds)
"""
