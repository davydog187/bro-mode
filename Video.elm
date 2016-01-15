module Video (Model, VideoDetails, init, view) where

import Html exposing (Html, div, h2, text)
import Html.Attributes exposing (class)

type alias VideoDetails = { headline: String, people: List String }
type alias Model = { stream: String, nowPlaying: VideoDetails, popularVideos: List VideoDetails }

init : String -> VideoDetails -> Model
init stream nowPlaying =
    {
        stream = stream
    ,   nowPlaying = nowPlaying
    ,   popularVideos = []
    }

view : Model -> Html
view video =
    div [ class "video" ]
        [
            div [ class "video__player" ] []
        ,   h2 [class "video__headline" ] [ text video.nowPlaying.headline ]
        ]
