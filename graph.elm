module Graph exposing (..)

import StaticData exposing (..)


type alias Graph =
    { nodes : List Node
    , edges : List Edge
    }


type GraphPath
    = GraphPath
        { node : Node
        , sub : List GraphPath
        }


filterGraph : Graph -> String -> Graph
filterGraph graph id =
    let
        ids =
            findIdsToBottom graph [ id ]
    in
        { nodes = List.filter (\n -> List.member n.id ids) graph.nodes
        , edges = List.filter (\n -> List.member n.from ids) graph.edges
        }


findIdsToBottom : Graph -> List String -> List String
findIdsToBottom graph ids =
    let
        found =
            List.filter (\e -> List.member e.from ids) graph.edges
                |> List.map (\e -> e.to)

        bottom =
            "VISION"

        bottomReached =
            List.member bottom found
    in
        if bottomReached then
            List.append ids found
        else
            findIdsToBottom graph found |> List.append ids


dddrr : List String -> String -> List String -> Bool
dddrr list needle =
    List.any (\a -> a == needle)


ddd : List String -> String -> List String -> Bool
ddd list needle =
    List.any (\a -> a == needle)


pathify : Graph -> Node -> GraphPath
pathify graph node =
    let
        findNodesFromGraph =
            findNodesByEdge graph

        pathifyGraph =
            pathify graph
    in
        GraphPath
            { node = node
            , sub =
                findEdgesByNode graph node
                    |> List.concatMap findNodesFromGraph
                    |> List.map pathifyGraph
            }


findNodeById : Graph -> String -> Maybe Node
findNodeById graph id =
    findNodesById graph id
        |> List.head


findNodesById : Graph -> String -> List Node
findNodesById graph id =
    List.filter (\n -> n.id == id) graph.nodes


findNodesByEdge : Graph -> Edge -> List Node
findNodesByEdge graph edge =
    let
        edgeConnectsTo =
            connectsTo edge
    in
        List.filter edgeConnectsTo graph.nodes


findEdgesByNode : Graph -> Node -> List Edge
findEdgesByNode graph node =
    let
        nodeConnectsFrom : Edge -> Bool
        nodeConnectsFrom =
            connectsFrom node
    in
        List.filter nodeConnectsFrom graph.edges


connectsTo : Edge -> Node -> Bool
connectsTo edge node =
    edge.to == node.id


connectsFrom : Node -> Edge -> Bool
connectsFrom node edge =
    edge.from == node.id
