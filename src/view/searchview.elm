module SearchView exposing (renderSearch, limitSearchResult, sortedNodes)

import Html exposing (Html)
import Html exposing (..)
import Html.Events as HEvent exposing (..)
import Html.Attributes as HAttr exposing (..)
import Msg exposing (..)
import Model exposing (State(..), Search, Year, Model)
import ModelBase exposing (Node)
import Graph exposing (..)


limitSearchResult : Int
limitSearchResult =
    50


renderSearch : Model -> Html Msg
renderSearch model =
    div [ id "search" ]
        [ input [ onInput Msg.Search, value model.search.searchString, placeholder "filter" ] []
        , renderChoices model.search.searchPrefix
        , renderSearchResult model.search
        ]


renderChoices : String -> Html Msg
renderChoices selected =
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
                [ ( "SO", "SO" )
                , ( "CSF", "CSF" )
                , ( "NC", "NC" )
                , ( "PRJ", "PRJ" )
                , ( "all", "" )
                ]


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
