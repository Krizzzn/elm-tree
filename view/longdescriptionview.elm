module LongdescriptionView exposing (renderLongdescription)

import Html exposing (Html)
import Html exposing (..)
import Html.Events as HEvent exposing (..)
import Html.Attributes as HAttr exposing (..)
import Model exposing (State(..), Year, Model)
import StaticData exposing (..)
import Graph exposing (..)
import Msg exposing (..)
import Markdown exposing (..)
import Sharepoint exposing (..)
import Json.Decode exposing (succeed)


renderLongdescription : Graph -> Maybe String -> Bool -> Html Msg
renderLongdescription graph maybeNodeId showImage =
    case maybeNodeId of
        Maybe.Nothing ->
            Html.text ""

        Maybe.Just node ->
            Graph.findNodeById graph node
                |> renderLongdescriptionOfNode showImage


renderLongdescriptionOfNode : Bool -> Maybe Node -> Html Msg
renderLongdescriptionOfNode showImage maybeNode =
    case maybeNode of
        Maybe.Nothing ->
            Html.text ""

        Maybe.Just node ->
            case node.description of
                Nothing ->
                    Html.text ""

                Just _ ->
                    let
                        showImageClass =
                            "hero"
                                ++ if showImage then
                                    ""
                                   else
                                    " hidden"
                    in
                        Html.div [ class "background", onClick Msg.HideDescription ]
                            [ div
                                [ class "content" ]
                                [ div [ class showImageClass ]
                                    [ img [ src (Sharepoint.getImageUrl node.id), on "error" (succeed Msg.HeroImageError) ] []
                                    ]
                                , Markdown.toHtml
                                    [ class "markdown" ]
                                    (renderNodeAsMarkdown node)
                                ]
                            ]


renderNodeAsMarkdown : Node -> String
renderNodeAsMarkdown node =
    let
        longdescription : String
        longdescription =
            case node.description of
                Just ld ->
                    ld

                Nothing ->
                    ""
    in
        "# [" ++ node.id ++ "] " ++ node.name ++ "\x0D\n" ++ longdescription
