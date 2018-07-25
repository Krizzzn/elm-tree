module View exposing (..)

import Html exposing (Html)
import Html exposing (..)
import Html.Events as HEvent exposing (..)
import Html.Attributes as HAttr exposing (..)
import Model exposing (State(..), Search, Year, Model)
import StaticData exposing (..)
import Graph exposing (..)
import Msg exposing (..)
import Sharepoint
import SearchView exposing (renderSearch)
import LongdescriptionView exposing (renderLongdescription)


view : Model -> Html Msg
view model =
    div [ id "container" ]
        [ renderYearPick model
        , renderLoadingBar
        , renderNetwork model
        ]


loadingAnimation : Model -> Html Msg
loadingAnimation model =
    let
        gif name =
            div [ class ("state " ++ name) ] []
    in
        case model.state of
            Loading ->
                gif "loading"

            Error ->
                gif "error"

            Ready ->
                text ""


renderYearPick : Model -> Html Msg
renderYearPick model =
    let
        selectedYear =
            Maybe.withDefault model.currentYear model.highlightYear

        years =
            [ ( selectedYear - 1, "◄" ), ( selectedYear + 1, "►" ) ]
                |> List.filter (\( y, _ ) -> y > (model.currentYear - 2))
                |> List.filter (\( y, _ ) -> y < (model.currentYear + 4))
    in
        header []
            [ h1 []
                [ text "Strategy"
                , text " - "
                , text (toString selectedYear)
                ]
            , div [ class "yearpick" ]
                (List.map
                    (\( y, label ) -> a [ onClick (Msg.ChangeYear (Maybe.Just y)) ] [ text label ])
                    years
                )
            , div [ class "clearfix" ] []
            ]


renderLoadingBar : Html Msg
renderLoadingBar =
    div [ id "loadingBar" ]
        [ div
            [ id "border" ]
            [ div [ id "bar" ] []
            ]
        ]


renderNetwork : Model -> Html Msg
renderNetwork model =
    div [ class "project-container" ]
        [ loadingAnimation model
        , div [ id "network" ] []
        , renderLongdescription model.graph model.showDescription model.displayImage
        , renderSearch model
        ]
