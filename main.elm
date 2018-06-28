-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/time.html


module Main exposing (..)

import Html exposing (Html)
import Html exposing (..)
import Html.Events as HEvent exposing (..)
import Html.Attributes as HAttr exposing (..)
import Time exposing (Time, second)
import List exposing (..)
import StaticData exposing (..)
import Graph exposing (..)
import SvgGraph exposing (..)
import JsGraph exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { graph : Graph
    , currentPath : Graph
    , currentFocus : String
    }


init : ( Model, Cmd Msg )
init =
    let
        defaultgraph =
            { nodes = projects
            , edges = connections
            }

        default : Model
        default =
            { graph = defaultgraph
            , currentPath = Graph.filterGraph defaultgraph "NC1"
            , currentFocus = "VISION"
            }
    in
        ( default, JsGraph.tree defaultgraph )



-- UPDATE


type Msg
    = Tick Time
    | ChangeSelection String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( model, Cmd.none )

        ChangeSelection newSelection ->
            let
                newModel =
                    { model | currentFocus = newSelection, currentPath = Graph.filterGraph model.graph newSelection }
            in
                ( newModel, JsGraph.tree newModel.currentPath )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    JsGraph.selectNode ChangeSelection



-- VIEW


view : Model -> Html Msg
view model =
    let
        node =
            Maybe.withDefault { id = "NC1", name = "?" } <|
                findNodeById model.currentPath "NC1"

        options =
            model.graph.nodes
    in
        div []
            [ Html.h1 [] [ text "The Graph" ]
            , select [ HEvent.onInput ChangeSelection ] <|
                List.map
                    (\n -> option [ value n.id ] [ text ("[" ++ n.id ++ "] " ++ n.name) ])
                    options
            , renderPath model.currentPath
            ]


renderPath : Graph -> Html msg
renderPath graph =
    div [ HAttr.style [ ( "marginLeft", "10px" ) ] ]
        [ text "9837"
        , SvgGraph.render ( "800", "350" ) graph

        -- , div [] <| List.map renderPath graphPath.sub
        ]


render : List Node -> String
render nodes =
    case head nodes of
        Maybe.Nothing ->
            "--"

        Maybe.Just node ->
            node.name
