module App exposing (init, update, view)

import Html exposing (..)
import Html.Attributes exposing (href)
import Http
import Json.Decode as Json exposing ( (:=) )

import Task exposing (..)

-- MODEL

type alias Model =
    { message : String
    , working : Bool
    }

init : (Model, Cmd Msg)
init = (Model "Loading..." False, loadData)

-- UPDATE

type Msg
    = FetchSucceed String
    | FetchFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        FetchSucceed str ->
            Model str True ! []
        FetchFail (Http.BadResponse 404 _) ->
            Model
                "I got a 404. This is the correct response if you ran serverless. Otherwise you need to check your configuration"
                True ! []
        FetchFail err ->
            Model (toString err) False ! []

-- VIEW

view : Model -> Html Msg
view {message, working} =
    div []
        [ h1 [] [ text "MEEN-Stack by Simon Hampton" ]
        , p [] [ text message ]
        , if working then
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
