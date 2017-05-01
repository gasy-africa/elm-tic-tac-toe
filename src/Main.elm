module Main exposing (..)

import Html exposing (Html, div, text)
import Html.Events exposing (onClick)
import List.Extra exposing (setAt)
import Maybe exposing (withDefault)


-- MODEL


type alias Model =
    { player1 : String
    , player2 : String
    , turn : String
    , board : List String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "X" "O" "X" [ "", "", "", "", "", "", "", "", "" ], Cmd.none )


type Msg
    = Mark Int



-- UPDATE


changeTurn : String -> String
changeTurn turn =
    if turn == "X" then
        "O"
    else
        "X"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mark int ->
            ( { model | board = withDefault [] (setAt int model.turn model.board), turn = changeTurn model.turn }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ div [ onClick (Mark 0) ] [ text "box1" ]
            , div [ onClick (Mark 1) ] [ text "box2" ]
            , div [ onClick (Mark 2) ] [ text "box3" ]
            ]
        , div []
            [ div [ onClick (Mark 3) ] [ text "box4" ]
            , div [ onClick (Mark 4) ] [ text "box5" ]
            , div [ onClick (Mark 5) ] [ text "box6" ]
            ]
        , div []
            [ div [ onClick (Mark 6) ] [ text "box7" ]
            , div [ onClick (Mark 7) ] [ text "box8" ]
            , div [ onClick (Mark 8) ] [ text "box9" ]
            ]
        ]



-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
