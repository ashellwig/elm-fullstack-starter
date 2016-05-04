module App exposing (init, update, view)

import Html exposing (..)
import Http
import Json.Decode as Json exposing ( (:=) )

import Task exposing (..)

-- MODEL

type alias Model = String

init : (Model, Cmd Msg)
init = ("Loading...", loadData)

-- UPDATE

type Msg
    = FetchSucceed String
    | FetchFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        FetchSucceed str ->
            (str, Cmd.none)
        FetchFail err ->
            (toString err, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text model ]
        ]

-- TASKS
loadData : Cmd Msg
loadData =
    Task.perform FetchFail FetchSucceed
    (Http.get ("data" := Json.string) "http://localhost:3000/api/default")
