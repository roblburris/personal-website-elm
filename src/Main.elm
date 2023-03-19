module Main exposing (..)

import Browser as Browser
import Browser.Navigation as Nav
import Url
import Url.Parser
import Html exposing (Html, text, div, h1, img, span, br, ul, li)
import Html.Attributes exposing (..)
import Page.Home as Home
import Page.About as About
import Page.Blog as Blog
import Page.Projects as Projects
import Json.Decode
import Http
import String exposing (slice)
import String exposing (toInt)
import Html exposing (a)
import Url.Parser exposing ((</>))
import Page exposing (Page(..))
import Markdown
import Markdown.Config exposing (Options, defaultOptions)
import Array exposing (Array)


-- MAIN
main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = always Sub.none
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }


type Route
  = Home
  | About
  | Resume
  | Projects
  | Blog
  | Post String

routeParser : Url.Parser.Parser (Route -> a) a
routeParser =
  Url.Parser.oneOf
    [ Url.Parser.map Home <| Url.Parser.top
    , Url.Parser.map About <| Url.Parser.s "about"
    , Url.Parser.map Resume <| Url.Parser.s "resume"
    , Url.Parser.map Projects <| Url.Parser.s "projects"
    , Url.Parser.map Blog <| (Url.Parser.s "blog")
    , Url.Parser.map Post <| (Url.Parser.s "post" </> Url.Parser.string)
    ]


---- MODEL ----


type alias Model =
  { key : Nav.Key
  , url : Url.Url
  , date : String
  , route : Maybe Route
  , blogEntries : List Blog.BlogEntry
  , posts : Array String
  }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
  ( {key = key
  , url = url
  ,route = Url.Parser.parse routeParser url
  , date = "December 2022"
  ,blogEntries = []
  , posts = Array.empty
  }
  , Cmd.batch [getLastUpdatedDate, getBlogs])




parseDate : String -> String
parseDate date =
  (Blog.numToMonth (toInt (slice 5 7 date))) ++ " " ++ (slice 0 4 date)


---- UPDATE ----

type Msg
  = GotHomeMsg
  | GotDate (Result Http.Error String)
  | LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url
  | GotBlogs (Result Http.Error (List Blog.BlogEntry))
  | GotPost (Result Http.Error String)




update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
      GotDate result ->
        case result of
          Ok date ->
            ( { model | date = parseDate date }, Cmd.none )
          Err _ ->
            ( model, Cmd.none )
      GotBlogs result ->
        case result of
            Ok blogEntries ->
              ( { model | blogEntries = blogEntries }, 
                Cmd.batch 
                  ((List.map (\b -> b.srcLink) blogEntries)
                  |> List.map(\l -> getBlogContent l)))
            Err _ ->
              ( model, Cmd.none )
      GotPost result ->
        case result of
            Ok content ->
              ( { model | posts = (Array.push content 
                model.posts) }, Cmd.none )
            Err _ ->
              ( model, Cmd.none )
      LinkClicked urlReq ->
        case urlReq of
            Browser.Internal url ->
              if (String.contains "resume" (Url.toString url)) then
                ( model, Nav.load "/assets/resume.pdf" )
              else
                ( model, Cmd.batch [Nav.pushUrl model.key (Url.toString url)])
            Browser.External href ->
              ( model, Nav.load href )
      UrlChanged url ->
        ( { model | route = Url.Parser.parse routeParser url, url = url }, Cmd.none)
      _ ->
        ( model, Cmd.none )

dateDecoder : Json.Decode.Decoder String
dateDecoder = 
  Json.Decode.at ["commit", "commit", "author", "date"] Json.Decode.string

blogDecoder : Json.Decode.Decoder (List Blog.BlogEntry)
blogDecoder =
  Json.Decode.list (
      Json.Decode.map2 Blog.BlogEntry 
        (Json.Decode.field "name" Json.Decode.string)
        (Json.Decode.field "download_url" Json.Decode.string)
  )
           
getLastUpdatedDate : Cmd Msg
getLastUpdatedDate =
  Http.get
    { url = "https://api.github.com/repos/roblburris/personal-blog/branches/master"
    , expect = Http.expectJson GotDate dateDecoder
    }

getBlogs : Cmd Msg
getBlogs =
  Http.get
    { url = "https://api.github.com/repos/roblburris/personal-blog/contents/"
    , expect = Http.expectJson GotBlogs blogDecoder
    }

getBlogURL : String -> List Blog.BlogEntry -> String
getBlogURL bName blogEntries =
  blogEntries
    |> List.filter (\b -> String.contains bName b.title)
    |> List.head
    |> Maybe.withDefault {title = "", srcLink = ""}
    |> (\x -> x.srcLink)


-- Blog Post View
customOptions : Options
customOptions =
    { defaultOptions
        | softAsHardLineBreak = True
    }

getBlogContent : String -> Cmd Msg
getBlogContent url =
  Http.get 
    { url = url
    , expect = Http.expectString GotPost
    }

getIndex : List a -> a -> Maybe Int
getIndex list element =
    List.indexedMap (\index value -> if value == element then Just index else Nothing) list
        |> List.filterMap identity
        |> List.head

getItemAtIndex : Int -> List a -> Maybe a
getItemAtIndex index list =
    List.drop index list
        |> List.head

getPostIndex : String -> List Blog.BlogEntry -> Int
getPostIndex name blogEntries =
  blogEntries 
    |> List.filter (\b -> String.contains name b.title)
    |> List.head
    |> Maybe.withDefault {title = "", srcLink = ""}
    |> getIndex blogEntries
    |> Maybe.withDefault 0



getPost : Int -> List String -> String
getPost index posts =
  (getItemAtIndex index posts)
    |> Maybe.withDefault ""


blogPostView : String -> { title : String, content : Html msg}
blogPostView content =
  { title = "Home"
  , content = div [] (Markdown.toHtml (Just customOptions) content )
  }

---- VIEW ----

view : Model -> Browser.Document Msg
view model =
  case model.route of
      Just Home ->
        Page.view model.date (Home.view)
      Just About ->
        Page.view model.date (About.view)
      Just Projects ->
        Page.view model.date (Projects.view)
      Just Blog ->
        Page.view model.date (Blog.view model.blogEntries)
      Just (Post title) ->
        Page.view model.date (blogPostView (getPost (getPostIndex title model.blogEntries) (Array.toList model.posts)))
      _ ->
        Page.view model.date (Home.view)


