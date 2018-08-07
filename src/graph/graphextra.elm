module GraphExtra exposing (..)

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
