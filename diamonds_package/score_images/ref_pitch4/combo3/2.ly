\version "2.20.0"
\language "english"

#(set-default-paper-size "a6" 'portrait)
#(set-global-staff-size 16)

\header {
    tagline = ##f
    title = \markup {
        \pad-around
            #3
            "Station 2"
        }
}

\layout {
    indent = #25
}

\paper {
    systems-per-page = 1
}

\score {
    \new Score
    <<
        \new Staff
        \with
        {
            \remove Time_signature_engraver
        }
        {
            \clef "treble"
            af''1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            +43.92c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            851.95
                            Hz
                        }
                }
            ^ \markup {
                \pad-around
                    #1
                    \box
                        \vcenter
                            \halign
                                #0
                                \bold
                                    {
                                        SumTone
                                    }
                }
            - \tweak color #blue
            _ \markup {
                \pad-around
                    #1
                    \box
                        \halign
                            #0
                            \italic
                                {
                                    23/8
                                }
                }
            \override Score.NonMusicalPaperColumn.padding = #5
            \clef "treble"
            af''1
            - \tweak color #blue
            _ \markup {
                \pad-around
                    #1
                    \box
                        \halign
                            #0
                            \italic
                                {
                                    23/15
                                }
                }
        }
        \new Staff
        \with
        {
            \remove Time_signature_engraver
        }
        {
            \clef "treble"
            d'1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            +15.64c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            296.33
                            Hz
                        }
                }
            ^ \markup {
                \pad-around
                    #1
                    \box
                        \vcenter
                            \halign
                                #0
                                \bold
                                    {
                                        Root1
                                    }
                }
            - \tweak color #blue
            _ \markup {
                \pad-around
                    #1
                    \box
                        \halign
                            #0
                            \italic
                                {
                                    8/7
                                }
                }
            \clef "treble"
            cs''1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            +3.91c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            555.62
                            Hz
                        }
                }
            ^ \markup {
                \pad-around
                    #1
                    \box
                        \vcenter
                            \halign
                                #0
                                \bold
                                    {
                                        Root2
                                    }
                }
            - \tweak color #blue
            _ \markup {
                \pad-around
                    #1
                    \box
                        \halign
                            #0
                            \italic
                                {
                                    15/7
                                }
                }
        }
        \new Staff
        \with
        {
            \remove Time_signature_engraver
        }
        {
            \clef "treble"
            c'1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            -15.53c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            259.29
                            Hz
                        }
                }
            ^ \markup {
                \pad-around
                    #1
                    \box
                        \vcenter
                            \halign
                                #0
                                \bold
                                    {
                                        DiffTone
                                    }
                }
            \clef "treble"
            c'1
        }
    >>
}