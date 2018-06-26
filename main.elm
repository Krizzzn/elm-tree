-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/time.html


module Main exposing (..)

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


type alias Model =
    Graph


init : ( Model, Cmd Msg )
init =
    let
        default : Graph
        default =
            { nodes = projects
            , edges = connections
            }
    in
        ( default, Cmd.none )



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        node =
            Maybe.withDefault { id = "NC1", name = "?" } <|
                findNodeById model "NC1"

        bgg =
            Graph.filterGraph model "NC5"

        bff =
            List.map (\a -> a.id) bgg.nodes
                |> Debug.log "debug 70:"

        path : GraphPath
        path =
            pathify model node
    in
        div []
            [ renderPath path
            , svg [ SAttr.width "500", SAttr.height "500", SAttr.viewBox "0 0 500 500" ]
                [ rect [ SAttr.x "10", SAttr.y "10", SAttr.width "100", SAttr.height "100", SAttr.rx "15", SAttr.ry "15" ] []
                ]
            ]


renderPath : GraphPath -> Html msg
renderPath path =
    let
        (GraphPath graphPath) =
            path
    in
        div [ HAttr.style [ ( "marginLeft", "10px" ) ] ]
            [ text (graphPath.node.name ++ "(" ++ graphPath.node.id ++ ")")
            , div [] <| List.map renderPath graphPath.sub
            ]


render : List Node -> String
render nodes =
    case head nodes of
        Maybe.Nothing ->
            "--"

        Maybe.Just node ->
            node.name
