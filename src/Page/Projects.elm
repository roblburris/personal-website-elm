module Page.Projects exposing (Model, view)

import Markdown

import Html exposing (..)
import Markdown.Config exposing (Options, defaultOptions)
type alias Model = {}

customOptions : Options
customOptions =
    { defaultOptions
        | softAsHardLineBreak = True
    }

example : String
example = """
# Markdown in elm!an e
"""


view : () -> { title : String, content : Html msg}
view model =
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
    , div [] (Markdown.toHtml (Just customOptions)  example )
    ]

    
  }
      

