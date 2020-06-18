module Styles exposing (..)

import Html
import Html.Attributes exposing (style)


container : List ( Html.Attribute msg )
container =
        [ style "display" "flex"
        , style "flex-direction" "column"
        , style "justify-content" "center"
        , style "align-items" "center"
        , style "widht" "100%"
        , style "height" "100vh"
        ]

 
innerContainer : List ( Html.Attribute msg )
innerContainer =
        [ style "display" "flex"
        ]


box : Html.Attribute msg -> List ( Html.Attribute msg )
box event =
        [ style "width" "100px"
        , style "height" "100px"
        , style "border" "1px solid black"
        , style "display" "flex"
        , style "justify-content" "center"
        , style "align-items" "center"
        , event
        ]


buttons : List ( Html.Attribute msg )
buttons =
        [ style "padding-top" "20px"
        , style "min-height" "40px"
        ]


chooseButtons : List ( Html.Attribute msg )
chooseButtons =
        [ style "display" "flex"
        , style "justify-content" "space-between"
        , style "padding-bottom" "20px"
        ]


containerChooseButtons : List ( Html.Attribute msg )
containerChooseButtons =
        [ style "min-height" "60px"
        ]


winner : List ( Html.Attribute msg )
winner =
        [ style "min-height" "60px"
        ]
