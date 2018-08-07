module DisplayOptionsView exposing (render)

import Html exposing (Html)
import Html exposing (..)
import Html.Events as HEvent exposing (..)
import Html.Attributes as HAttr exposing (..)
import Msg exposing (..)
import Model exposing (State(..), Search, Year, Model, Display)
import ModelBase exposing (Node)
import Graph exposing (..)


render : Model -> Html Msg
render model =
    div [ class "displayLevels" ] <|
        List.append [ Html.text "Show:" ] <|
            List.map (renderOption model.display.hide) model.display.types


renderOption : List String -> ( String, String ) -> Html Msg
renderOption selected ( option, _ ) =
    case option of
        "all" ->
            Html.text ""

        _ ->
            Html.label []
                [ Html.input
                    [ type_ "checkbox"
                    , onClick (Msg.ChangeDisplay option)
                    , checked (not (List.member option selected))
                    ]
                    []
                , Html.text option
                ]
