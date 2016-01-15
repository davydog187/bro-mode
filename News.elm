module News (Model, update, init, view, Action) where

import Http
import Json.Decode as Json exposing((:=))
import Html exposing (Html, div, button, text, span)
import Html.Attributes exposing (style)
import Task
import Effects exposing (Effects)
import Story

type alias Model =
    { stories: List Story.Model
    , hasStories: Bool
    }

type Action = NewStories (Maybe (List Story.Model))

init : (Model, Effects Action)
init =
    (   Model [] False
    ,   fetchStoriesList
    )

storiesDecoder : Json.Decoder Story.Model
storiesDecoder = Json.object2 Story.Model
        ("headline" := Json.string)
        ("link" := Json.string)

itemsExtractor : Json.Decoder (List Story.Model)
itemsExtractor = ("items" := Json.list storiesDecoder)

fetchStoriesList : Effects Action
fetchStoriesList =
    Http.get (itemsExtractor) storiesEndpoint
        |> Task.toMaybe
        |> Task.map NewStories
        |> Effects.task

storiesEndpoint : String
storiesEndpoint =
    "http://localhost:5000/bromode/stories"

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        NewStories maybeStories -> let
                                       stories = (Maybe.withDefault [] maybeStories)
                                       hasStories = List.length stories > 0
                                   in
                                      (
                                          { model | stories = stories, hasStories = hasStories }
                                          , Effects.none
                                      )

view : Signal.Address Action -> Model -> Html
view address model =
    case model.hasStories of
        True -> let
                    storyList = List.map Story.view model.stories
                in
                   div [ newsStyle ] storyList
        False ->
            div [ imgStyle "assets/loading_gif.gif" ] []

imgStyle : String -> Html.Attribute
imgStyle url =
    style
        [   ("display", "inline-block")
        ,   ("width", "500px")
        ,   ("height", "500px")
        ,   ("background-position", "center center")
        ,   ("background-size", "50% 50%")
        ,   ("background-repeat", "no-repeat")
        ,   ("background-image", ("url('" ++ url ++ "')"))
        ,   ("background-color", "#707D82")
        ]


newsStyle : Html.Attribute
newsStyle =
    style
        [   ("width", "500px")
        ,   ("min-height", "500px")
        ,   ("background-color", "#707D82")
        ]
