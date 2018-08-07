module SearchView exposing (renderSearch, limitSearchResult, sortedNodes)

import Html exposing (Html)
import Html exposing (..)
import Html.Events as HEvent exposing (..)
import Html.Attributes as HAttr exposing (..)
import Msg exposing (..)
import Model exposing (State(..), Search, Year, Model)
import ModelBase exposing (Node)
import Graph exposing (..)
import DisplayOptionsView exposing (render)


limitSearchResult : Int
limitSearchResult =
    50


renderSearch : Model -> Html Msg
renderSearch model =
    div [ id "search" ]
        [ DisplayOptionsView.render model
        , input [ onInput Msg.Search, value model.search.searchString, placeholder "filter", type_ "text" ] []
        , renderChoices model.search.searchPrefix model.display.types
        , renderSearchResult model.search
        ]


renderChoices : String -> List ( String, String ) -> Html Msg
renderChoices selected types =
    let
        selectedClass b =
            if selected == b then
                "selected"
            else
                ""
    in
        div [ id "choice" ] <|
            List.map
                (\( lbl, val ) -> a [ onClick (Msg.SearchPrefix val), class (selectedClass val) ] [ text lbl ])
                types


renderSearchResult : Search -> Html Msg
renderSearchResult search =
    if List.length search.projects > 0 then
        ul [ class "shown" ] <|
            List.indexedMap (renderNodeInFinder search.highlight) <|
                sortedNodes search.projects
    else
        text ""


renderNodeInFinder : Int -> Int -> Node -> Html Msg
renderNodeInFinder selected idx node =
    let
        className =
            if selected == (idx + 1) then
                "selected"
            else
                ""
    in
        li [ class className ]
            [ a [ href ("#" ++ node.id) ] [ text ("[" ++ node.id ++ "] " ++ node.name) ]
            ]


sortedNodes : List Node -> List Node
sortedNodes nodes =
    List.take limitSearchResult <|
        List.sortBy (\node -> node.id) <|
            nodes
