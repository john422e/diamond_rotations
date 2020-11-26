import sys, os
from random import randrange, choice
import abjad
import FMfunctions as fm
import chain_functions as cf
import lilypond_output as lyo
import file_io as fio

score_directory = "/Users/johneagle/projects/music/COMP/taceti/diamonds_package/score_images/"

# starting pitch?
# each diamond connection?
# number of iterations? is there a limit?
# catalog method?
# png conversion?

# for checking instrument range (check sidebands only)
high_freq = 880;
low_freq = 110;

# don't need these parameters anymore
a440 = 440.0
fundamental = 110 # A2
primes = [2, 3/2, 5/4, 7/4]
hz_min = 100
hz_max = 1000
#
prime_set = cf.get_unique_set(primes, 2)
#print("PRIME INTERVALS:", prime_set)

# get pitch (0=C4) to start chain, needs to be high enough that first
# step won't go too low

# number of semitones to offset pitch by
offset = -5

all_freqs = []

for i in range(7):
    # iterate through each possible starting pitch
    start = i + offset
    pitch = abjad.NamedPitch(start)
    start_freq = pitch.hertz
    #print(start)

    folder = "ref_pitch{}".format(i)
    directory = score_directory + folder
    if not os.path.exists(directory):
        os.mkdir(directory)
    #print(folder)

    # get each possible prime ratio combination
    combo_num = 0
    for j, ratio1 in enumerate(primes):
        for k in range(j+1, len(primes) ):
            sub_folder = "combo{}".format(combo_num)
            combo_num += 1
            #print(sub_folder)

            # build prime set
            ratio2 = primes[k]
            prime_set = [ratio1, ratio2]
            chain = cf.build_diamond(start_freq, prime_set)
            sidebands = cf.get_sequential_sidebands(chain)

            directory = score_directory + folder + '/' + sub_folder + '/'
            if not os.path.exists(directory):
                os.mkdir(directory)

            station_num = 1
            for pair in sidebands:
                #print("Freqs:", pair[0])
                #print("\tSidebands:", pair[1])
                freqs = {
                    'Root 1': pair[0][0],
                    'Root 2': pair[0][1],
                    'Sum Tone': pair[1][0][0],
                    'Diff Tone': pair[1][1][0]
                    }
                # check high and low for instrument range
                if freqs['Sum Tone'] > high_freq and freqs['Diff Tone'] < low_freq:
                    high_freq = freqs['Sum Tone']
                    low_freq = freqs['Diff Tone']
                    print("RANGE CHECK: ", low_freq, high_freq)

                lyo.output_part(directory, freqs, part=station_num)
                # output csv file with freqs
                csv_filename = directory + 'freqs.csv'
                rounded_freqs = [round(i, 2) for i in chain]
                fio.output_csv(csv_filename, [rounded_freqs])
                station_num += 1

print("LOW/HIGH: ", low_freq, high_freq)
