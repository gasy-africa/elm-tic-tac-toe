module Main exposing (..)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import List.Extra exposing (setAt, getAt)
import Maybe exposing (withDefault)
import String exposing (toUpper)


-- INTERNAL MODULES

import Styles exposing (..)


-- MODEL


type alias Model =
    { player1 : String
    , player2 : String
    , turn : String
    , board : List String
    , isBoardFull : Bool
    , hasSetPlayer : Bool
    }


initModel : Model
initModel =
    Model "X" "O" "X" [ "", "", "", "", "", "", "", "", "" ] False False


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )



-- UPDATE HELPERS


handleChangeTurn : String -> String
handleChangeTurn turn =
    case turn of
        "X" ->
            "O"

        _ ->
            "X"


handleBoardFull : List String -> Bool
handleBoardFull =
    not << List.any (\v -> v == "")



-- UPDATE


type Msg
    = Mark Int
    | Reset
    | SetPlayer String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mark int ->
            let
                nextBoard =
                    if getValue int model == "" then
                        withDefault [] (setAt int model.turn model.board)
                    else
                        model.board

                nextTurn =
                    if getValue int model == "" then
                        handleChangeTurn model.turn
                    else
                        model.turn

                isBoardFull =
                    handleBoardFull nextBoard
            in
                { model
                    | board = nextBoard
                    , turn = nextTurn
                    , isBoardFull = isBoardFull
                }
                    ! []

        Reset ->
            initModel ! []

        SetPlayer str ->
            { model
                | player1 = str
                , player2 = handleChangeTurn str
                , turn = str
                , hasSetPlayer = True
            }
                ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW HELPERS


getValue : Int -> Model -> String
getValue int model =
    getAt int model.board |> withDefault ""



-- VIEW


view : Model -> Html Msg
view model =
    div [ container ]
        [ div []
            [ if not model.hasSetPlayer then
                div [ containerChooseButtons ]
                    [ text (toUpper "Choose Player")
                    , div [ chooseButtons ]
                        [ button [ onClick (SetPlayer "X") ] [ text "Player X" ]
                        , button [ onClick (SetPlayer "O") ] [ text "Player O" ]
                        ]
                    ]
              else
                div [ containerChooseButtons ] []
            ]
        , div [ innerContainer ]
            [ div [ box, onClick (Mark 0) ] [ text (getValue 0 model) ]
            , div [ box, onClick (Mark 1) ] [ text (getValue 1 model) ]
            , div [ box, onClick (Mark 2) ] [ text (getValue 2 model) ]
            ]
        , div [ innerContainer ]
            [ div [ box, onClick (Mark 3) ] [ text (getValue 3 model) ]
            , div [ box, onClick (Mark 4) ] [ text (getValue 4 model) ]
            , div [ box, onClick (Mark 5) ] [ text (getValue 5 model) ]
            ]
        , div [ innerContainer ]
            [ div [ box, onClick (Mark 6) ] [ text (getValue 6 model) ]
            , div [ box, onClick (Mark 7) ] [ text (getValue 7 model) ]
            , div [ box, onClick (Mark 8) ] [ text (getValue 8 model) ]
            ]
        , div [ buttons ]
            [ if model.isBoardFull then
                button [ onClick Reset ] [ text "Reset" ]
              else
                text ""
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
