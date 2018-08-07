module GraphExtra exposing (removeLevel, incoming, calculateProgress, calculateProgressesOfLevel)

import Graph exposing (Graph)
import ModelBase exposing (Node, Edge)


removeLevel : String -> Graph -> Graph
removeLevel levelName graph =
    let
        edges =
            flattenEdges levelName graph.edges

        idsToKeep =
            List.concat <|
                List.map (\e -> [ e.to, e.from ]) edges

        nodes =
            List.filter (\node -> List.member node.id idsToKeep) graph.nodes
    in
        { graph | edges = edges, nodes = nodes }


calculateProgressesOfLevel : String -> Graph -> Graph
calculateProgressesOfLevel level graph =
    let
        ( calculate, keep ) =
            List.partition (\e -> String.startsWith level e.id) graph.nodes

        nodes =
            List.append keep <| List.map ((flip calculateProgress) graph) calculate
    in
        { graph | nodes = nodes }


flattenEdges : String -> List Edge -> List Edge
flattenEdges levelName edges =
    let
        ( repl, keep ) =
            List.partition (\edge -> String.startsWith levelName edge.to || String.startsWith levelName edge.from) edges
    in
        List.append keep <|
            List.concat <|
                List.map flattenEdge <|
                    List.map
                        (\edge ->
                            ( edge
                            , List.filter (\k -> k.from == edge.to) repl
                            )
                        )
                        repl


flattenEdge : ( Edge, List Edge ) -> List Edge
flattenEdge ( from, to ) =
    List.map
        (\edge ->
            { from = from.from
            , to = edge.to
            , edgetype = from.edgetype
            }
        )
        to


incoming : Node -> Graph -> List Node
incoming node graph =
    let
        incomingIds =
            List.map (\edge -> edge.from) <|
                List.filter (\a -> a.to == node.id) graph.edges
    in
        List.filter (\n -> List.member n.id incomingIds) graph.nodes


calculateProgress : Node -> Graph -> Node
calculateProgress node graph =
    let
        incomingNodes =
            incoming node graph
    in
        { node | progress = Maybe.map round (totalProgress incomingNodes) }


totalProgress : List Node -> Maybe Float
totalProgress nodes =
    let
        total =
            List.sum <|
                List.map toFloat <|
                    List.map (\e -> Maybe.withDefault 0 e.progress) nodes

        contains =
            not <| List.all (\e -> e.progress == Maybe.Nothing) nodes
    in
        if contains then
            Maybe.Just (total / (toFloat (List.length nodes)))
        else
            Maybe.Nothing
