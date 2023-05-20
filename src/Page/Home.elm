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
            studying Computer Science with a minor in Art History. After graduating, I'm excited to be joining Palantir as a Software Engineer. Here you'll find a collection of my
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
            text "Current Coursework: History and Theory of Photography (ART H 273), Art of the Andes (ART H 309), 19th and 20th Century Art (ART H 380), Startup Seminar (CSE 492 M)"
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
      
