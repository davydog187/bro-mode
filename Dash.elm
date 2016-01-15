import Html exposing (Html, div, h2, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, style)
import Graphics.Element exposing (show)
import Task exposing (Task, andThen, onError, succeed)
import StartApp
import TaskTutorial exposing (print)
import String

import Effects exposing (Never)

import News
import Video

app =
    StartApp.start
        { init = News.init
        , update = News.update
        , view = News.view
        , inputs = []
        }

main = app.html

port tasks : Signal (Task Never ())
port tasks =
    app.tasks

{-}
    Signal.map storyToText storiesMailbox.signal

storyToText : List Story.Model -> Html
stories stories =
    let
        lines = List.map (String.)
    text (String.concat [story.headline, " ", story.link])

  --StartApp.start { model = init, view = view, update = update }
  -}

{-
type alias Model = 
    {
        news: News.Model
    ,   video: Video.Model
    }

init : Model
init =
    let
        videoDetails =
            { headline = "Donald Trump gets a Haircut", people = ["Donald Trump", "Bob Dole"] }
    in
        {
            news = News.init
        ,   video = Video.init "Live" videoDetails
        }

type Actions = Noop
update action model =
  case action of
    Noop -> model

view : Signal.Address Actions -> Model -> Html
view address model =
      div [ ]
        [
            div [ style [ ("float", "left") ] ] [(News.view model.news)]
        ,   div [ style [ ("float", "right") ] ] [(Video.view model.video)]
        ]
        -}
