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
                            -37.29c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            812.91
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
                                    29/8
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
                                    29/21
                                }
                }
        }
        \new Staff
        \with
        {
            \remove Time_signature_engraver
        }
        {
            \clef "bass"
            a1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            +33.13c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            224.25
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
                                    8/13
                                }
                }
            \clef "treble"
            d''1
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
                            588.66
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
                                    21/13
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
            fs'1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            -26.34c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            364.41
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
            fs'1
        }
    >>
}