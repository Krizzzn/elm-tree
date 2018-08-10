module HeaderView exposing (renderYearPick)

import Html exposing (Html)
import Html exposing (..)
import Html.Events as HEvent exposing (..)
import Html.Attributes as HAttr exposing (..)
import Msg exposing (..)
import Model exposing (Year, Model)
import Config exposing (head)
import DateArit exposing (..)


renderYearPick : Year -> Html Msg
renderYearPick year =
    let
        selectedYear =
            Maybe.withDefault year.current year.highlight

        focus =
            if year.focus then
                1
            else
                0

        years =
            [ ( selectedYear - 1, "◄" )
            , ( focus, "focus" )
            , ( selectedYear + 1, "►" )
            ]
                |> List.map (\( y, lbl ) -> ( y, lbl, ((getYear y) > ((getYear year.current) - 2) && (getYear y) < ((getYear year.current) + 4)) ))
    in
        header []
            [ h1 []
                [ text head
                , text " - "
                , text (renderYear selectedYear)
                ]
            , div [ class "yearpick" ]
                (renderButtons years)
            , div [ class "clearfix" ] []
            ]


renderYear : Int -> String
renderYear year =
    case getQuarter year of
        Just quarter ->
            (getYear year |> toString) ++ " Q" ++ (toString quarter)

        Nothing ->
            year |> toString


renderButtons : List ( Int, String, Bool ) -> List (Html Msg)
renderButtons years =
    (List.map
        renderButton
        years
    )


renderButton : ( Int, String, Bool ) -> Html Msg
renderButton ( y, label, visible ) =
    case ( y, label, visible ) of
        ( 0, "focus", _ ) ->
            a [ onClick (Msg.FocusYear True) ] [ text "focus" ]

        ( 1, "focus", _ ) ->
            a [ onClick (Msg.FocusYear False) ] [ text "-all-" ]

        ( _, _, False ) ->
            a [ onClick (Msg.DoNothing), class "invisible" ] [ text label ]

        ( _, _, _ ) ->
            a [ onClick (Msg.ChangeYear (Maybe.Just y)) ] [ text label ]
