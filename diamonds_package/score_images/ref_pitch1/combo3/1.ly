\version "2.20.0"
\language "english"

#(set-default-paper-size "a6" 'portrait)
#(set-global-staff-size 16)

\header {
    tagline = ##f
    title = \markup {
        \pad-around
            #3
            "Station 1"
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
            bf'1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            -35.0c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            456.84
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
                                    11/5
                                }
                }
            \override Score.NonMusicalPaperColumn.padding = #5
            \clef "treble"
            bf'1
            - \tweak color #blue
            _ \markup {
                \pad-around
                    #1
                    \box
                        \halign
                            #0
                            \italic
                                {
                                    11/6
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
                            +0.0c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            207.65
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
                                    5/1
                                }
                }
            \clef "bass"
            b1
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
                            249.18
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
                                    6/1
                                }
                }
        }
        \new Staff
        \with
        {
            \remove Time_signature_engraver
        }
        {
            \clef "bass_8"
            e,,1
            - \tweak color #red
            ^ \markup {
                \halign
                    #0
                    \italic
                        {
                            +13.69c
                        }
                }
            ^ \markup {
                \halign
                    #1
                    \italic
                        {
                            41.53
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
            \clef "bass_8"
            e,,1
        }
    >>
}