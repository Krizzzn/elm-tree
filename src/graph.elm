module Graph exposing (Graph, highlightYear, filter, findNodeById, findNodesById, findNodesByString, filterGraph, filterGraphByIds, filterGraphByIdsAndType, idExists)

import StaticData exposing (..)


type alias Graph =
    { nodes : List Node
    , edges : List Edge
    , filter : List Edge
    }


filter : (Node -> Bool) -> Graph -> Graph
filter fn graph =
    filterGraphByIds graph <|
        List.map (\n -> n.id) <|
            List.filter fn graph.nodes


highlightYear : Maybe Int -> Graph -> Graph
highlightYear year graph =
    let
        selected =
            List.map
                (\n ->
                    if n.year == Maybe.Just 0 then
                        { n | year = year }
                    else if n.year == year then
                        n
                    else
                        { n | year = Maybe.Nothing }
                )
                graph.nodes
    in
        { graph | nodes = selected }


reverseGraph : Graph -> Graph
reverseGraph graph =
    { nodes = graph.nodes
    , edges = List.map reverseNode graph.edges
    , filter = graph.filter
    }


reverseNode : Edge -> Edge
reverseNode edge =
    { from = edge.to
    , to = edge.from
    , edgetype = edge.edgetype
    }


filterGraph : String -> Graph -> Graph
filterGraph id graph =
    let
        ids =
            vistGraph graph [ id ] ++ vistGraph (reverseGraph graph) [ id ]
    in
        filterGraphByIds graph ids


filterGraphByIds : Graph -> List String -> Graph
filterGraphByIds graph ids =
    { nodes = List.filter (\n -> List.member n.id ids) graph.nodes
    , edges = List.filter (\n -> List.member n.from ids) graph.edges
    , filter = graph.filter
    }


filterGraphByIdsAndType : Graph -> List String -> Graph
filterGraphByIdsAndType graph ids =
    let
        other =
            getTypesFromGraph graph
                |> List.filter (\e -> not (List.any (\a -> (String.left 2 a) == e) ids))

    in
        { nodes = List.filter (\n -> List.member n.id ids || List.member (String.left 2 n.id) other) graph.nodes
        , edges = List.filter (\n -> List.member n.from ids || List.member (String.left 2 n.from) other) graph.edges
        , filter = graph.filter
        }


getTypesFromGraph : Graph -> List String
getTypesFromGraph graph =
    List.map (\e -> String.left 2 e.id) graph.nodes


vistGraph : Graph -> List String -> List String
vistGraph graph ids =
    let
        filterToNewIds =
            filterNewIds ids

        found =
            List.filter (\e -> List.member e.from ids) graph.edges
                |> List.map (\e -> e.to)
                |> filterToNewIds
    in
        if List.length found == 0 then
            List.append ids found
        else
            List.append ids found
                |> vistGraph graph


filterNewIds : List String -> List String -> List String
filterNewIds list1 list2 =
    List.filter (\e -> not <| List.member e list1) list2


idExists : Graph -> String -> Bool
idExists graph id =
    let
        count : Int
        count =
            List.filter (\n -> id == n.id) graph.nodes |> List.length
    in
        count > 0


findNodeById : Graph -> String -> Maybe Node
findNodeById graph id =
    findNodesById graph id
        |> List.head


findNodesById : Graph -> String -> List Node
findNodesById graph id =
    List.filter (\n -> String.startsWith id n.id) graph.nodes


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


findNodesByString : String -> List Node -> List Node
findNodesByString findByString nodes =
    List.filter (filterNode findByString) nodes


filterNode : String -> Node -> Bool
filterNode find node =
    let
        -- split items at Whitespace into list
        findAtoms =
            String.toLower find |> String.split " " |> List.filter (\e -> not <| String.isEmpty e)

        matchNode : Node -> String -> Bool
        matchNode n needle =
            String.contains needle (String.toLower (n.name ++ " " ++ n.id))
    in
        List.all (matchNode node) findAtoms
