module News (Model, update, init, view, Action) where

import Html exposing (Html, div, button, text, span)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import Effects
import Story

{-}
main =
    StartApp.start { model = init, view = view, update = update }
    -}

type alias Model = { stories: List Story.Model }

init : Model
init =
    {  stories = [
            Story.init "headline one" "stuff",
            Story.init "headline two" "stuff",
            Story.init "headline three" "stuff",
            Story.init "headline four" "stuff",
            Story.init "headline five" "stuff",
            Story.init "headline six" "stuff",
            Story.init "headline seven" "stuff"
        ]
    }

type Action = UpdateData Model

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        UpdateData newData -> ({ model | stories = newData.stories }, Effects.none)

view : Signal.Address -> Model -> Html
view address model =
    let
        storyList = List.map Story.view model.stories
    in
        div [ class "news" ] storyList


