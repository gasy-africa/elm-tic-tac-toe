module Main exposing (..)

import Browser
import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import List exposing (all, any, filter)
import List.Extra exposing (setAt, getAt, groupsOf, transpose, indexedFoldl)
import Maybe exposing (withDefault)
import Random exposing (generate)
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
    , hasWinner : Bool
    , hasStarted : Bool
    }


initModel : Model
initModel =
    Model "X" "O" "X" [ "", "", "", "", "", "", "", "", "" ] False False False False


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


hasWinner : Model -> Bool
hasWinner { board, turn } =
    let
        rows =
            groupsOf 3 board |> any (all ((==) turn))

        columns =
            groupsOf 3 board |> transpose |> any (all ((==) turn))

        backward =
            indexedFoldl
                (\idx curr acc ->
                    if idx == 0 || idx == 4 || idx == 8 then
                        curr :: acc
                    else
                        acc
                )
                []
                board
                |> all ((==) turn)

        forward =
            indexedFoldl
                (\idx curr acc ->
                    if idx == 2 || idx == 4 || idx == 6 then
                        curr :: acc
                    else
                        acc
                )
                []
                board
                |> all ((==) turn)
    in
        any (\truthy -> truthy)
            [ rows, columns, backward, forward ]



-- UPDATE


type Msg
    = Mark Int
    | Reset
    | SetPlayer String
    | Rand Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mark int ->
            let
                nextBoard =
                    if getValue int model == "" then
                        withDefault [] (Just (setAt int model.turn model.board))
                    else
                        model.board

                nextWinner =
                    hasWinner { model | board = nextBoard }

                nextTurn =
                    if getValue int model == "" then
                        handleChangeTurn model.turn
                    else
                        model.turn

                isBoardFull =
                    handleBoardFull nextBoard

                nextCmd =
                    if model.player1 == model.turn && not isBoardFull then
                        randoInt
                    else
                        Cmd.none
            in
                if nextWinner then
                    ( { model | hasWinner = True, board = nextBoard } , Cmd.none )

                else
                    ( { model
                        | board = nextBoard
                        , turn = nextTurn
                        , isBoardFull = isBoardFull
                        , hasStarted = True
                    }
                        , nextCmd )

        Reset ->
            ( initModel , Cmd.none )

        Rand num ->
            let
                hasValue =
                    getValue num model /= ""
            in
                if hasValue then
                    ( model , randoInt )
                else
                    update (Mark num) model

        SetPlayer str ->
            ({ model
                | player1 = str
                , player2 = handleChangeTurn str
                , turn = str
                , hasSetPlayer = True
            }
                , Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- UPDATE HELPERS


randoInt : Cmd Msg
randoInt =
    generate Rand (Random.int 0 8)



-- VIEW HELPERS


getValue : Int -> Model -> String
getValue int model =
    getAt int model.board |> withDefault ""



-- VIEW


view : Model -> Html Msg
view model =
    div   container
        [ div []
            [ if not model.hasSetPlayer then
                div   containerChooseButtons
                    [ if model.hasStarted then
                        text ""
                      else
                        text (toUpper "Choose Player")
                    , if model.hasStarted then
                        text ""
                      else
                        div   chooseButtons
                            [ button [ onClick (SetPlayer "X") ] [ text "Player X" ]
                            , button [ onClick (SetPlayer "O") ] [ text "Player O" ]
                            ]
                    ]
              else
                div   containerChooseButtons []
            ]
        , div   innerContainer
            [ div (box (onClick (Mark 0))) [ text (getValue 0 model) ]
            , div (box (onClick (Mark 1))) [ text (getValue 1 model) ]
            , div (box (onClick (Mark 2))) [ text (getValue 2 model) ]
            ]
        , div   innerContainer
            [ div (box (onClick (Mark 3))) [ text (getValue 3 model) ]
            , div (box (onClick (Mark 4))) [ text (getValue 4 model) ]
            , div (box (onClick (Mark 5))) [ text (getValue 5 model) ]
            ]
        , div   innerContainer
            [ div (box (onClick (Mark 6))) [ text (getValue 6 model) ]
            , div (box (onClick (Mark 7))) [ text (getValue 7 model) ]
            , div (box (onClick (Mark 8))) [ text (getValue 8 model) ]
            ]
        , div   buttons
            [ if model.isBoardFull || model.hasWinner then
                button [ onClick Reset ] [ text "Reset" ]
              else
                text ""
            ]
        , div   winner
            [ if model.hasWinner then
                text (model.turn ++ " has won!")
              else
                text ""
            ]
        ]



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
