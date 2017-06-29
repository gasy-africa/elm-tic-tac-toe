module Styles exposing (..)

import Html
import Html.Attributes exposing (style)


container : Html.Attribute msg
container =
    style
        [ ( "display", "flex" )
        , ( "flex-direction", "column" )
        , ( "justify-content", "center" )
        , ( "align-items", "center" )
        , ( "widht", "100%" )
        , ( "height", "100vh" )
        ]


innerContainer : Html.Attribute msg
innerContainer =
    style
        [ ( "display", "flex" )
        ]


box : Html.Attribute msg
box =
    style
        [ ( "width", "100px" )
        , ( "height", "100px" )
        , ( "border", "1px solid black" )
        , ( "display", "flex" )
        , ( "justify-content", "center" )
        , ( "align-items", "center" )
        ]


buttons : Html.Attribute msg
buttons =
    style
        [ ( "padding-top", "20px" )
        , ( "min-height", "40px" )
        ]


chooseButtons : Html.Attribute msg
chooseButtons =
    style
        [ ( "display", "flex" )
        , ( "justify-content", "space-between" )
        , ( "padding-bottom", "20px" )
        ]


containerChooseButtons : Html.Attribute msg
containerChooseButtons =
    style
        [ ( "min-height", "60px" )
        ]


winner : Html.Attribute msg
winner =
    style
        [ ( "min-height", "60px" )
        ]
