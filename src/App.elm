module App exposing (init, update, view)

import Html exposing (..)
import Html.Attributes exposing (href)
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
        [ h1 [] [ text "MEEN-Stack by Simon Hampton" ]
        , p [] [ text model ]
        , if model == "Working!!!" then
            div []
                [ text "Have you thought about adding a Github star? "
                , a [ href "https://github.com/simonh1000/elm-fullstack-starter" ]
                    [ text "Click here" ]
                ]
          else text ""
        ]

-- TASKS
loadData : Cmd Msg
loadData =
    Http.get ("data" := Json.string) "http://localhost:3000/api/default"
    |> Task.perform FetchFail FetchSucceed
