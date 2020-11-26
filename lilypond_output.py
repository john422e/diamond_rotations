import os
import abjad
from math import log2
from decimal import Decimal
import chain_functions as cf
import file_io as fio

# lilypond functions ----------------------------------------------------------
def make_empty_score(max_voices):
    staves = []
    for voice in range(max_voices):
        staff = abjad.Staff()
        staves.append(staff)
    score = abjad.Score(staves)
    return score

def get_cent_deviation(f1, f2):
    # f1 is high freq, f2 is low
    cents = 1200 * log2(f2/f1)
    cents = float(round(Decimal(cents), 2))
    return cents

def get_markup(val, font='italic', label=None, plus_sign=False, direction=abjad.Up, halign=0):
    """
    takes input value and returns a lilypond markup
    """

    # add '+' sign to postive numbers
    if plus_sign and (isinstance(val, int) or isinstance(val, float)):
        if val >= 0:
            val = "+" + str(val)

    # cast to string
    val = str(val)
    # add label if provided
    if label:
        val += label

    markup = r'\{font}'.format(font=font)
    markup += " { " + val + " }"
    markup = abjad.Markup(markup, direction=direction)
    markup = markup.halign(halign)
    return markup

def get_literal(literal_string):
    literal = abjad.LilyPondLiteral(literal_string, 'after')
    return literal

def get_12TET_pitch_from_hertz(freq):
    # no quarter tones!
    # returns abjad pitch object and cents value
    pitch = abjad.NamedPitch.from_hertz(freq) # this will round to the nearest quarter tone
    pitch_freq = pitch.hertz # Hz of whatever it is rounded to
    cents = get_cent_deviation(pitch_freq, freq) # returns the difference in cents
    if 'qs' or 'qf' in pitch.name:
        # if True, then adjust based on cent deviation and round to nearest 12-TET pitch
        # and redo abjad pitch object and cents value
        if cents > 0:
            # transpose up quarter step
            pitch = abjad.NamedPitch(pitch.number + 0.25)
        else:
            # transpose down
            pitch = abjad.NamedPitch(pitch.number - 0.25)
        # now get new cents deviation
        pitch_freq = pitch.hertz
        cents = get_cent_deviation(pitch_freq, freq)
    return pitch, cents

def build_measure(score, voice, freq, label=None, show_hz=True, show_cents=True, f2=None):
    """
    extends one voice, one measure, one note, with attached markups
    """
    # add note
    pitch, cents = get_12TET_pitch_from_hertz(freq)
    score[voice].extend(pitch.name + "1")

    # set clef based on range
    if pitch.number < -24: # lower than C2
        clef = abjad.Clef('bass_8')
    elif pitch.number < 0: # lower than C4
        clef = abjad.Clef('bass')
    else:
        clef = abjad.Clef('treble')
    # attach clef
    abjad.attach(clef, score[voice][-1])

    # markups
    if show_cents:
        cents_markup = get_markup(cents, plus_sign=True, label='c')
        abjad.tweak(cents_markup).color = 'red'
        abjad.attach(cents_markup, score[voice][-1])
    if show_hz:
        freq = round(freq, 2)
        freq_markup = get_markup(str(freq) + " Hz", halign=1)
        abjad.attach(freq_markup, score[voice][-1])
    if label:
        label_markup = get_markup(label, font='bold').vcenter().box().pad_around(1)
        abjad.attach(label_markup, score[voice][-1])
    if f2:
        # display ratio
        ratio = cf.get_ratio(freq, f2)
        ratio_string = str(ratio.numerator) + '/' + str(ratio.denominator)
        ratio_markup = get_markup(ratio_string, direction=abjad.Down).box().pad_around(1)
        abjad.tweak(ratio_markup).color = 'blue'
        abjad.attach(ratio_markup, score[voice][-1])



def output_part(directory, freqs, part=1, png_conversion=True):
    """
    takes in freqs dictionary with keys "Root 1", "Root 2",
    "Sum Tone", "Diff Tone"
    and outputs lilypond part
    """

    score = make_empty_score(3)
    sum_tone = freqs['Sum Tone']
    diff_tone = freqs['Diff Tone']
    root1 = freqs['Root 1']
    root2 = freqs['Root 2']

    # MEASURE 1 (Root 1)

    # Summation Tone
    voice = 0
    # hide time signature
    score[voice].remove_commands.append('Time_signature_engraver')
    abjad.f(score[voice])
    build_measure(score, voice, sum_tone, label='SumTone', f2=root1)

    # Root 1
    voice = 1
    # hide time signature
    score[voice].remove_commands.append('Time_signature_engraver')
    abjad.f(score[voice])
    build_measure(score, voice, root1, label='Root1', f2=diff_tone)

    # Difference Tone
    voice = 2
    # hide time signature
    score[voice].remove_commands.append('Time_signature_engraver')
    abjad.f(score[voice])
    build_measure(score, voice, diff_tone, label='DiffTone')

    # add some space at end of measure
    measure_space = get_literal(r'\override Score.NonMusicalPaperColumn.padding = #5')
    abjad.attach(measure_space, score[0][-1])

    # MEASURE 2 (Root 2)

    # Summation Tone
    voice = 0
    build_measure(score, voice, sum_tone, f2=root2, show_hz=False, show_cents=False)

    # Root 1
    voice = 1
    build_measure(score, voice, root2, label='Root2', f2=diff_tone)

    # Difference Tone
    voice = 2
    build_measure(score, voice, diff_tone, show_hz=False, show_cents=False)

    # make filename
    #png_stem = str(part) + ".png"
    pdf_stem = str(part) + ".pdf"
    filename = directory + pdf_stem
    title = 'Station {}'.format(part)

    lilypond_file = abjad.LilyPondFile.new(score, global_staff_size=16,
                                        default_paper_size=('a6', 'portrait'))
    lilypond_file.layout_block.indent = 25
    lilypond_file.header_block.title = abjad.Markup(title).pad_around(3)
    #lilypond_file.header_block.composer = abjad.Markup('John Eagle')
    lilypond_file.paper_block.items.append("systems-per-page = 1")

    abjad.show(lilypond_file, open_file=False, pdf_file_path=filename)
    if png_conversion:
        fio.convertPDF_toPNG(directory, pdf_stem)
