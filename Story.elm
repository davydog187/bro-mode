module Story (Model, init, view) where

import Html exposing (Html, div, h2, text, a)
import Html.Attributes exposing (class, href, target)

type alias Model = { headline: String, link: String }

init : String -> String -> Model
init headline link =
    {
        headline = headline
    ,   link = link
    }

view : Model -> Html
view story =
    div [ class "story" ]
        [ h2 [class "story__headline" ]
            [ a [ class "story__link", href story.link, target "_blank" ] [ text story.headline ] ]
        ]
