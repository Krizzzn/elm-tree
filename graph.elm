module Graph exposing (..)

type alias Node =
  { id : String
  , name : String
  }

type alias Edge =
  { from : String
  , to : String
  }

type alias Graph =
  {  nodes : List Node
  ,  edges : List Edge
  }

type GraphPath = GraphPath
  { node : Node
  , sub  : List GraphPath
  }

pathify : Graph -> Node -> GraphPath
pathify graph node =
  let
    findNodesFromGraph = findNodesByEdge graph
    pathifyGraph = pathify graph
  in

  GraphPath 
    { node = node
    , sub = findEdgesByNode graph node |> 
            List.concatMap findNodesFromGraph |> 
            List.map pathifyGraph
  } 

findNodeById : Graph -> String -> Maybe Node
findNodeById graph id =
  findNodesById graph id |>
    List.head

findNodesById : Graph -> String -> List Node
findNodesById graph id =
  List.filter (\n -> n.id == id) graph.nodes

findNodesByEdge : Graph -> Edge -> List Node
findNodesByEdge graph edge =
  let
    edgeConnectsTo = connectsTo edge
  in
    List.filter edgeConnectsTo graph.nodes

findEdgesByNode : Graph -> Node -> List Edge
findEdgesByNode graph node =
  let
    nodeConnectsFrom : Edge -> Bool
    nodeConnectsFrom = connectsFrom node
  in
    List.filter nodeConnectsFrom graph.edges      

connectsTo : Edge -> Node -> Bool
connectsTo edge node =
  edge.to == node.id

connectsFrom : Node -> Edge -> Bool 
connectsFrom node edge =
  edge.from == node.id


