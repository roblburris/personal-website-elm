module Page.Projects exposing (view)
import Html exposing (..)
view : { title : String, content : Html msg}
view =
  { title = "Home"
  , content =
    div []
    [ h1 [] [ text "Projects" ]
    , span [] [
         text
           """
            Here are some of the school and personal projects that I'm most proud of.
            """
    ]
    , h2 [][text "TODO"]
    ]

    
  }
      

