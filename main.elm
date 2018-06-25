-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/time.html

import Html exposing (Html)
import Html exposing (..)
import Html.Attributes as HAttr exposing (..)
import Svg exposing (svg, rect)
import Svg.Attributes as SAttr exposing (..)
import Time exposing (Time, second)
import List exposing (..)

import StaticData exposing (..)
import Graph exposing (..)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

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

type alias Model = Graph


init : (Model, Cmd Msg)
init =
  let
    default : Graph
    default = 
      { nodes = projects 
      , edges = connections
      }
  in
    
  (default, Cmd.none)

makeNode : (String, String) -> Node
makeNode nodeTuple = 
  {  id = Tuple.first nodeTuple
  ,  name = Tuple.second nodeTuple
  }

makeEdge : (String, String) -> Edge
makeEdge edgeTuple = 
  {  from = Tuple.first edgeTuple
  ,  to = Tuple.second edgeTuple
  }

-- UPDATE


type Msg
  = Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      (model, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW

view : Model -> Html Msg
view model =
  let
    node = Maybe.withDefault { id = "NC1", name = "?" } <| 
      findNodeById model "NC36"

    path : GraphPath
    path = pathify model node
  in
      
    div [] [
        renderPath path
      , svg [ SAttr.width "500", SAttr.height "500", SAttr.viewBox "0 0 500 500" ] [ 
          rect [ SAttr.x "10", SAttr.y "10", SAttr.width "100", SAttr.height "100", SAttr.rx "15", SAttr.ry "15" ] [] 
        ]
      ]

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

renderPath : GraphPath -> Html msg
renderPath path =
  let
    (GraphPath graphPath) = path
  in

  div [ HAttr.style [("marginLeft", "10px")] ] [
    text (graphPath.node.name ++ "(" ++ graphPath.node.id ++ ")")
    , div [] <| List.map renderPath graphPath.sub
   ]


render : List Node -> String
render nodes =
  case head nodes of
    Maybe.Nothing ->
      "--"
    Maybe.Just node ->
      node.name



