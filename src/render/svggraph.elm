module SvgGraph exposing (..)

import Tuple exposing (..)
import Html exposing (Html)
import Svg exposing (svg, rect)
import Svg.Attributes as SAttr exposing (..)
import Graph exposing (..)
import ModelBase exposing (Node)
import Set exposing (..)


type alias GraphNode =
    { node : Node
    , position : ( Int, Int )
    }


type alias GraphEdge =
    { positionFrom : ( Int, Int )
    , positionTo : ( Int, Int )
    }


render : ( String, String ) -> Graph -> Html.Html msg
render dimensions graph =
    let
        graphify =
            splitList graph
                |> List.indexedMap (\i list -> positionize i list)
                |> List.foldr (++) []

        edgify =
            getEdges graph graphify
    in
        svg [ SAttr.width (first dimensions), SAttr.height (second dimensions), SAttr.viewBox ("0 0 " ++ (first dimensions) ++ " " ++ (second dimensions) ++ "") ] <|
            renderNodes graphify
                ++ renderEdges edgify


getEdges : Graph -> List GraphNode -> List GraphEdge
getEdges graph nodes =
    let
        nodeExistsInGraph =
            nodeExists graph.nodes

        positionFromNode =
            positionFromGraphNodes nodes
    in
        List.filter (\e -> nodeExistsInGraph (e.from) && nodeExistsInGraph (e.to)) graph.edges
            |> List.map
                (\e ->
                    { positionFrom = positionFromNode e.from
                    , positionTo = positionFromNode e.to
                    }
                )


positionFromGraphNodes : List GraphNode -> String -> ( Int, Int )
positionFromGraphNodes nodes find =
    List.filter (\e -> e.node.id == find) nodes
        |> List.map (\e -> e.position)
        |> List.head
        |> Maybe.withDefault ( 0, 0 )


nodeExists : List Node -> String -> Bool
nodeExists nodes find =
    List.any (\a -> a.id == find) nodes


renderEdges : List GraphEdge -> List (Svg.Svg msg)
renderEdges edges =
    List.map renderEdge edges


renderEdge : GraphEdge -> Svg.Svg msg
renderEdge edge =
    Svg.line [ x1 (toString ((Tuple.first edge.positionFrom) * 70 + 0)), y1 (toString ((Tuple.second edge.positionFrom) * 70 + 5)), strokeWidth "1", x2 (toString ((Tuple.first edge.positionTo) * 70 + 0)), y2 (toString ((Tuple.second edge.positionTo) * 70 - 5)), stroke "gray" ] []


renderNodes : List GraphNode -> List (Svg.Svg msg)
renderNodes graph =
    List.map renderNode graph


renderNode : GraphNode -> Svg.Svg msg
renderNode node =
    Svg.circle [ SAttr.cx (toString ((Tuple.first node.position) * 70)), SAttr.cy (toString ((Tuple.second node.position) * 70)), SAttr.r "5" ]
        [ Svg.title []
            [ Svg.text node.node.name ]
        ]


positionize : Int -> List Node -> List GraphNode
positionize level nodes =
    List.indexedMap (\i node -> toGraphNode ( i + 1, level + 1 ) node) nodes


splitList : Graph -> List (List Node)
splitList graph =
    distinctNodesTypes graph
        |> Set.toList
        |> List.map (\s -> Graph.findNodesById graph s)


distinctNodesTypes : Graph -> Set String
distinctNodesTypes graph =
    Set.fromList <|
        List.map (\n -> String.slice 0 2 n.id) graph.nodes


toGraphNode : ( Int, Int ) -> Node -> GraphNode
toGraphNode position node =
    { node = node
    , position = (position)
    }
