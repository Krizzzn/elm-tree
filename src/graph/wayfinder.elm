module Wayfinder exposing (traverse, traverseGraph, flatten, ids)

import ModelBase exposing (Edge)
import Graph exposing (Graph)


type Path
    = Path
        { path : List Edge
        , sub : List Path
        }


traverseGraph : List Edge -> Graph -> Path
traverseGraph edges graph =
    concatPath <|
        List.append (List.map (\edge -> traverse edge graph.edges) (edges)) <|
            List.map (\edge -> traverse edge graph.edges) (invert edges)


invert : List Edge -> List Edge
invert edges =
    List.map
        (\edge ->
            { from = edge.to
            , to = edge.from
            , edgetype = edge.edgetype
            }
        )
        edges



--traverse edge graph.edges
-- traverses the path and returns only paths that move throu the POIs


traverse : Edge -> List Edge -> Path
traverse fromTo edges =
    let
        (Path traversed) =
            Tuple.first <|
                traverse2 fromTo edges
    in
        Path
            { path = traversed.path
            , sub = traversed.sub
            }


traverse2 : Edge -> List Edge -> ( Path, Bool )
traverse2 fromTo edges =
    let
        category =
            String.left 2 fromTo.to

        connectionsTo =
            List.filter (\e -> ((not (String.startsWith category e.to)) || e.to == fromTo.to)) <|
                List.filter (\e -> (e.from == fromTo.from)) <|
                    edges

        found =
            List.any (\e -> e.to == fromTo.to) connectionsTo
    in
        case (found) of
            True ->
                ( Path
                    { path = connectionsTo
                    , sub = []
                    }
                , True
                )

            False ->
                let
                    sub =
                        List.map Tuple.first <|
                            List.filter (\( _, f ) -> f) <|
                                List.map (\e -> traverse2 { from = e.to, to = fromTo.to, edgetype = e.edgetype } edges) <|
                                    connectionsTo
                in
                    ( Path
                        { path = connectionsTo
                        , sub = sub
                        }
                    , List.length sub > 0
                    )



-- flatten a path


flatten : Path -> List Edge
flatten p =
    let
        (Path path) =
            p
    in
        List.append path.path <|
            List.concat <|
                List.map flatten path.sub


removeLooseEnds : List Edge -> List Edge -> List Edge
removeLooseEnds targets path =
    let
        goals =
            List.append (List.map (\node -> node.to) targets) (List.map (\node -> node.from) path)
    in
        List.filter (\edge -> List.member edge.to goals) path



-- extract ids


ids : List Edge -> Path -> List String
ids targets path =
    List.concat <|
        List.map (\e -> [ e.to, e.from ]) <|
            removeLooseEnds targets <|
                flatten path



-- merges two paths together


concatPath : List Path -> Path
concatPath paths =
    let
        edges : List Edge
        edges =
            List.concat <| List.map (\(Path a) -> a.path) paths

        sub : List Path
        sub =
            List.concat <| List.map (\(Path a) -> a.sub) paths
    in
        Path
            { path = edges
            , sub = sub
            }
