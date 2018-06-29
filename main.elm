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
import Navigation


main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { graph : Graph
    , location : Navigation.Location
    , currentPath : Graph
    , currentFocus : String
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        defaultgraph =
            { nodes = projects
            , edges = connections
            }

        currentPath =
            getCurrentFocus defaultgraph <|
                String.dropLeft 1 location.hash

        default : Model
        default =
            { graph = defaultgraph
            , location = location
            , currentPath = Graph.filterGraph defaultgraph currentPath
            , currentFocus = currentPath
            }
    in
        ( default, JsGraph.tree default.currentPath )



-- UPDATE


type Msg
    = ChangeSelection String
    | UrlChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeSelection newSelection ->
            let
                m =
                    model.location

                location =
                    { m | hash = "#" ++ newSelection }
            in
                ( model, Navigation.modifyUrl (location.pathname ++ location.hash) )

        UrlChange location ->
            let
                newSelection =
                    getCurrentFocus model.graph <|
                        String.dropLeft 1 location.hash

                newModel =
                    { model | location = location, currentFocus = newSelection, currentPath = Graph.filterGraph model.graph newSelection }
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
            , div
                [ id "mynetwork"
                , style
                    [ ( "height", "500px" )
                    , ( "width", "90%" )
                    , ( "border", "1px solid black" )
                    ]
                ]
                []
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


getCurrentFocus : Graph -> String -> String
getCurrentFocus graph hash =
    let
        exists =
            Graph.idExists graph hash
    in
        if exists then
            hash
        else
            "VISION"
