module Page.Blog exposing (view, BlogEntry, numToMonth)

import Html exposing (..)
import Array
import Html.Attributes exposing (style)
import Html.Attributes exposing (href)

type alias BlogEntry =
    { title : String
    , srcLink : String
    }
  

numToMonth : Maybe Int -> String
numToMonth m =
  case m of
    Just month ->
      case month of
        1 -> "January"
        2 -> "February"
        3 -> "March"
        4 -> "April"
        5 -> "May"
        6 -> "June"
        7 -> "July"
        8 -> "August"
        9 -> "September"
        10 -> "October"
        11 -> "November"
        12 -> "December"
        _ -> "NULL"
    Nothing -> "NULL"

listToTuple2 : List a -> Maybe (a, a)
listToTuple2 l =
  case l of
      [a, b] ->
        Just (a, b)
      _ ->
        Nothing

maybeStringToMaybeInt : Maybe String -> Maybe Int
maybeStringToMaybeInt s =
  String.toInt ((Maybe.withDefault "1" s))

convertDate : String -> String
convertDate date =
  String.replace ".md" "" date
    |> String.split "-" 
    |> Array.fromList
    |> \a -> 
        Array.set 0 (numToMonth (maybeStringToMaybeInt (Array.get 0 a))) a
    |> \arr -> Array.set 1 ((String.fromInt 
        (Maybe.withDefault 0 
          (maybeStringToMaybeInt (Array.get 1 arr)))
        ) ++ "," ) arr
    |> Array.toList
    |> String.join "\u{0020}"

parseTitleAndDate: (String, String) -> (String, String)
parseTitleAndDate t = 
  (Tuple.first t |> (String.replace "-" "\u{0020}"), Tuple.second t |> convertDate)


blogEntryHTML : BlogEntry -> Html msg
blogEntryHTML blog =
  let
      titleDateTuple = Maybe.withDefault ("", "")( listToTuple2 (String.split "__" blog.title))
      titleDate = parseTitleAndDate titleDateTuple
  in
  div [] [
    span [style "color" "gray"
      , style "font-size" "calc(7px + 1vmin)"
      , style "text-decoration" "none!important"][text (Tuple.second titleDate)]
    , br [][]
    , a [href ("/post/" ++ ((String.replace "\u{0020}" "-" (Tuple.first titleDateTuple)))), style "font-size" "calc(12px + 1vmin)"][text (Tuple.first titleDate)]
  ]
  


view : List BlogEntry -> { title : String, content : Html msg}
view blogs =
  { title = "Home"
  , content =
    div []
    [ h1 [] [ text "Blog" ]
    , span [] [
         text
           """
            Here's a collection of my thoughts and experiences across a variety of topics. These will most likely be pretty infrequent posts but hopefully I'll amass a collection of blog posts in the near future! As always, these writings are representative of myself and none of the entities I'm associated with :)
            """
    ]
    , h2 [][text "Posts"]
    , div [] (List.map blogEntryHTML blogs)
  ]
    
  }
      
