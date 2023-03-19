module Page exposing (..)

import Browser exposing (Document)
import Html exposing (Html, text, div, span, a, br)
import Html.Attributes exposing (class, style)
import Html.Events exposing (..)
import Html.Attributes exposing (href)

type Page
  = Home
    | About
    | Blog
    | Projects
    | Contact

navbar : Html msg
navbar =
  div [class "Navbar"] (List.map 
    (\s -> 
      a [class "NavItem", style "grid-column" (Tuple.second s), href ("/" ++ (String.toLower (Tuple.first s))) ][text (Tuple.first s)])
      
      (List.map2 
        (\x y ->
          (x, (String.fromInt y)))
        ["Home", "About", "Resume", "Projects", "Blog"] (List.range 2 6)
      )
  )

view : String -> {title : String, content : Html msg}  -> Document msg
view date {title, content} =
  { title = title
  , body = [div [class "Page"] [
      navbar,
      div [class "Content"] [
        content
        , br [] []
        , footer date
      ]
    ]]
  }

footer : String -> Html msg
footer date =
    div [class "Footer"]
    [
      div [class "FooterBar"][]
      , span [class "FooterContents"]
        [ text ("Made by Robert Burris. Built in Elm. Last updated "
          ++  date
          ++ "."
        )  
      ]
    ]