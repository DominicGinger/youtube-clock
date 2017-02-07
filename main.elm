module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Time exposing (Time, second)
import Date exposing (..)


youtubeUrl =
    "https://www.youtube.com/embed?autoplay=1&loop=1&rel=0&controls=0&listType=search&list="


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( youtubeUrl, Cmd.none )


type Msg
    = Tick Time


displayPartTime fn time =
    toString (fn (fromTime time))


displayAmPm time =
    if (Date.minute (fromTime time)) > 12 then
        "pm"
    else
        "am"


displayTime time =
    (displayPartTime Date.hour time)
        ++ ":"
        ++ (displayPartTime Date.minute time)
        ++ displayAmPm time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( youtubeUrl ++ (displayTime time), Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every Time.second Tick


view : Model -> Html Msg
view model =
    iframe [ src model, style [ ( "width", "100%" ), ( "height", "100%" ), ( "border", "none" ), ( "position", "absolute" ) ] ] []
