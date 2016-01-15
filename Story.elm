module Story (Model, init, view) where

import Html exposing (Html, div, h2, text, a)
import Html.Attributes exposing (href, target, style)

type alias Model = { headline: String, link: String }

init : String -> String -> Model
init headline link =
    {
        headline = headline
    ,   link = link
    }

view : Model -> Html
view story =
    div [ storyStyle ]
        [ h2 [ style [ ("margin", "0")]]
            [ a [ linkStyle, href story.link, target "_blank" ] [ text story.headline ] ]
        ]

storyStyle : Html.Attribute
storyStyle =
    style
        [   ("height", "30px")
        ,   ("border-bottom", "1px solid #90A4AB")
        ,   ("text-align", "center")
        ,   ("padding", "10px 0")
        ]

linkStyle : Html.Attribute
linkStyle =
    style
        [   ("font-size", "12px")
        ,   ("color", "#FFFFFF")
        ]
