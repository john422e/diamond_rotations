\version "2.20.0"
\language "english"

#(set-default-paper-size "a6" 'portrait)
#(set-global-staff-size 16)

\header {
    tagline = ##f
    title = \markup {
        \pad-around
            #3
            "Station 4"
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
            c''''1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            -29.22c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            2057.98
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
                                    7/4
                                }
                }
            \override Score.NonMusicalPaperColumn.padding = #5
            \clef "treble"
            c''''1
            - \tweak color #blue
            _ \markup {
                \pad-around
                    #1
                    \box
                        \halign
                            #0
                            \italic
                                {
                                    7/3
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
            d'''1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            +1.96c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            1175.99
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
                                    4/1
                                }
                }
            \clef "treble"
            a''1
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
                            881.99
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
                                    3/1
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
                            +1.96c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            294.0
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
            d'1
        }
    >>
}