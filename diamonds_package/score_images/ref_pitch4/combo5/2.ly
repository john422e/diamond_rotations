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
            cs''1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            +24.4c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            562.23
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
                                    51/16
                                }
                }
            \override Score.NonMusicalPaperColumn.padding = #5
            \clef "treble"
            cs''1
            - \tweak color #blue
            _ \markup {
                \pad-around
                    #1
                    \box
                        \halign
                            #0
                            \italic
                                {
                                    51/35
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
            f1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            +17.49c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            176.39
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
                                    16/19
                                }
                }
            \clef "treble"
            g'1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            -27.37c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            385.85
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
                                    35/19
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
            af1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            +15.0c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            209.46
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
            \clef "bass"
            af1
        }
    >>
}