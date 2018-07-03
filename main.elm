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
import Markdown
import Keyboard


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
    , showDescription : Maybe String
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
            , showDescription = Maybe.Nothing
            }
    in
        ( default, JsGraph.tree default.currentPath )



-- UPDATE


type Msg
    = ChangeSelection String
    | UrlChange Navigation.Location
    | ShowDescription String
    | HideDescription
    | KeyMsg Keyboard.KeyCode


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
                    { model | location = location, currentPath = Graph.filterGraph model.graph newSelection, showDescription = Maybe.Nothing }
            in
                ( newModel, JsGraph.tree newModel.currentPath )

        ShowDescription nodeId ->
            ( { model | showDescription = Maybe.Just nodeId }, Cmd.none )

        HideDescription ->
            ( { model | showDescription = Maybe.Nothing }, Cmd.none )

        KeyMsg code ->
            case code of
                13 ->
                    ( { model | showDescription = Maybe.Nothing }, Cmd.none )

                27 ->
                    ( { model | showDescription = Maybe.Nothing }, Cmd.none )

                _ ->
                    ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ JsGraph.selectNode ChangeSelection
        , JsGraph.showNode ShowDescription
        , Keyboard.downs KeyMsg
        ]



-- VIEW


view : Model -> Html Msg
view model =
    let
        node =
            Maybe.withDefault { id = "NC1", name = "?", description = "" } <|
                findNodeById model.currentPath "NC1"

        options =
            model.graph.nodes
    in
        div []
            [ Html.h1 [] [ text "The Graph" ]
            , div [ class "project-container" ]
                [ div [ id "network" ] []
                , renderLongdescription model.graph model.showDescription
                ]

            --, select [ HEvent.onInput ChangeSelection ] <|
            --    List.map
            --        (\n -> option [ value n.id ] [ text ("[" ++ n.id ++ "] " ++ n.name) ])
            --        options
            --, renderPath model.currentPath
            ]


renderLongdescription : Graph -> Maybe String -> Html msg
renderLongdescription graph maybeNodeId =
    case maybeNodeId of
        Maybe.Nothing ->
            Html.text ""

        Maybe.Just node ->
            Graph.findNodeById graph node
                |> renderLongdescriptionOfNode


renderLongdescriptionOfNode : Maybe Node -> Html msg
renderLongdescriptionOfNode maybeNode =
    case maybeNode of
        Maybe.Nothing ->
            Html.text ""

        Maybe.Just node ->
            Html.div [ class "background" ]
                [ Markdown.toHtml [ class "content" ] (renderNodeAsMarkdown node)
                ]


renderNodeAsMarkdown : Node -> String
renderNodeAsMarkdown node =
    "# [" ++ node.id ++ "] " ++ node.name ++ "\x0D\n" ++ node.description



-- body


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
