\version "2.20.0"
\language "english"

#(set-default-paper-size "a6" 'portrait)
#(set-global-staff-size 16)

\header {
    tagline = ##f
    title = \markup {
        \pad-around
            #3
            "Station 5"
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
            a'''1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            -1.6c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            1758.38
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
                                    29/21
                                }
                }
            \override Score.NonMusicalPaperColumn.padding = #5
            \clef "treble"
            a'''1
            - \tweak color #blue
            _ \markup {
                \pad-around
                    #1
                    \box
                        \halign
                            #0
                            \italic
                                {
                                    29/8
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
            ef'''1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            +39.61c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            1273.31
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
                                    21/13
                                }
                }
            \clef "treble"
            b'1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            -31.17c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            485.07
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
                                    8/13
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
            g''1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            +9.35c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            788.24
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
            g''1
        }
    >>
}