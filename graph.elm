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


reverseGraph : Graph -> Graph
reverseGraph graph =
    { nodes = graph.nodes
    , edges = List.map reverseNode graph.edges
    }


reverseNode : Edge -> Edge
reverseNode edge =
    { from = edge.to
    , to = edge.from
    }


filterGraph : Graph -> String -> Graph
filterGraph graph id =
    let
        ids =
            vistGraph graph [ id ] ++ vistGraph (reverseGraph graph) [ id ]
    in
        { nodes = List.filter (\n -> List.member n.id ids) graph.nodes
        , edges = List.filter (\n -> List.member n.from ids) graph.edges
        }


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
            , sub = []

            --findEdgesByNode graph node
            --    |> List.concatMap findNodesFromGraph
            --    |> List.map pathifyGraph
            }


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


findNodesByString : Maybe String -> Graph -> List Node
findNodesByString findByString graph =
    case findByString of
        Just find ->
            List.filter (filterNode find) graph.nodes

        Nothing ->
            []


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
