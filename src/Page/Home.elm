module Page.Home exposing (view)

import Html exposing (..)

  
view : { title : String, content : Html msg}
view =
  { title = "Home"
  , content =
    div []
    [ h1 [] [ text "Welcome!" ]
    , span [] [
         text
           """
            I'm Robert Burris, a senior at the University of Washington
            studying Computer Science with minors in Art History and Mathematics. After graduating, I'm excited to be joining Palantir as a Software Engineer. Here you'll find a collection of my
            various projects, blog posts, a copy of my resume, and info on 
            where to contact me.
            """
        ]
    , br [] []
    , br [] []
    , span [] [
         text
           """
            In the meantime, here's some info about me!
            """
        ]
    , ul [] [
          li [] [
            text "Current Coursework: Theory of Computation (CSE 431), Visual Culture - Michelangelo (ART H 204), Art of Mesoamerica (ART H 309), Introduction to Real Estate (RE 250)"
          ]
          , li [] [
            text "Ongoing Projects:"
            , ul [] [
              li [] [
                text "Rewriting my Personal Website in Elm"
              ]
            ]
          ]
          , li [] [
            text "What I'm Currently Reading:"
            , ul [] [
              li [] [
                text "Modern Poker Theory by Michael Acevedo"
              ]
            ]
          ]
          , li [] [
            text "What I'm Currently Listening to:"
            , ul [] [
              li [] [
                text "All-In Podcast"
              ]
            ]
          ]
        ]
    ]
  }
      
