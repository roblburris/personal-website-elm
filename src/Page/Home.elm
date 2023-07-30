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
            I'm Robert Burris, a Software Engineer at Palantir. I graduated from the University of Washington with a BS in Computer Science and minor in Art History in 2023. Broadly speaking, my interests lie in building performant low latency distributed systems. Here you'll find a collection of my
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
      
