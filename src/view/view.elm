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
import HeaderView exposing (renderYearPick)


view : Model -> Html Msg
view model =
    div [ id "container" ]
        [ renderYearPick model.year
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
