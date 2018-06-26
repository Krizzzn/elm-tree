module SvgGraph exposing (..)

import Tuple exposing (..)
import Html exposing (Html)
import Svg exposing (svg, rect)
import Svg.Attributes as SAttr exposing (..)


render : ( String, String ) -> Html.Html msg
render dimensions =
    svg [ SAttr.width (first dimensions), SAttr.height (second dimensions), SAttr.viewBox "0 0 500 500" ]
        [ rect [ SAttr.x "10", SAttr.y "10", SAttr.width "100", SAttr.height "100", SAttr.rx "15", SAttr.ry "15" ] []
        , Svg.text_ [ SAttr.x "250", SAttr.y "50" ] [ Svg.text "asdasd" ]
        ]
