import Html exposing (Html, div, h2, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, style)
import Graphics.Element exposing (show)
import Task exposing (Task, andThen, onError, succeed)
import Json.Decode as Json exposing((:=))
import Http
import StartApp.Simple as StartApp
import TaskTutorial exposing (print)
import String

import Story
import News
import Video

main =
    Signal.map text storiesMailbox.signal

storyToText : Story.Model -> Html
storyToText story =
    text (String.concat [story.headline, story.link])

  --StartApp.start { model = init, view = view, update = update }

storiesMailbox : Signal.Mailbox (List Story.Model)
storiesMailbox = Signal.mailbox ""

--reportStories : List Story.Model -> Task x (List Story.Model)
reportStories : List Story.Model -> Task Http.Error a
reportStories storiesToReport =
    Signal.send storiesMailbox.address storiesToReport

storyDecoder = Json.object2 Story.Model
    ("headline" := Json.string)
    ("link" := Json.string)

port fetchStories : Task Http.Error (List Story.Model)
port fetchStories =
    (Http.get (Json.list storyDecoder) storiesUrl) `andThen` reportStories

storiesUrl : String
storiesUrl =
    "http://localhost:5000/bromode/stories"


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
