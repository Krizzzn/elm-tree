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
import Msg exposing (Msg)
import Sharepoint


main =
    Navigation.program Msg.UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type State
    = Loading
    | Error
    | Ready


type alias Model =
    { graph : Graph
    , location : Navigation.Location
    , currentPath : Graph
    , showDescription : Maybe String
    , state : State
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        defaultgraph =
            { nodes = []
            , edges = []
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
            , state = Loading
            }
    in
        ( default, Cmd.batch [ Sharepoint.getJsonData Sharepoint.Edges, Sharepoint.getJsonData Sharepoint.Nodes ] )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.ChangeSelection newSelection ->
            let
                m =
                    model.location

                location =
                    { m | hash = "#" ++ newSelection }
            in
                ( model, Navigation.modifyUrl (location.pathname ++ location.hash) )

        Msg.UrlChange location ->
            let
                newSelection =
                    getCurrentFocus model.graph <|
                        String.dropLeft 1 location.hash

                newModel =
                    { model | location = location, currentPath = Graph.filterGraph model.graph newSelection, showDescription = Maybe.Nothing }
            in
                ( newModel, JsGraph.tree newModel.currentPath )

        Msg.ShowDescription nodeId ->
            ( { model | showDescription = Maybe.Just nodeId }, Cmd.none )

        Msg.HideDescription ->
            ( { model | showDescription = Maybe.Nothing }, Cmd.none )

        Msg.KeyMsg code ->
            case code of
                13 ->
                    ( { model | showDescription = Maybe.Nothing }, Cmd.none )

                27 ->
                    ( { model | showDescription = Maybe.Nothing }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        Msg.DoNothing ->
            ( model, Cmd.none )

        Msg.EdgesLoaded (Ok edges) ->
            let
                graph =
                    model.graph

                newmodel =
                    { model | graph = { graph | edges = edges } }
            in
                displayModel newmodel

        Msg.EdgesLoaded (Err e) ->
            let
                _ =
                    Debug.log "Error occured:" e
            in
                ( { model | state = Error }, Cmd.none )

        Msg.NodesLoaded (Ok nodes) ->
            let
                graph =
                    model.graph

                newmodel =
                    { model | graph = { graph | nodes = nodes } }
            in
                displayModel newmodel

        Msg.NodesLoaded (Err e) ->
            let
                _ =
                    Debug.log "Error occured:" e
            in
                ( { model | state = Error }, Cmd.none )

        Msg.MorePlease ->
            let
                _ =
                    Debug.log "foo is" "foo3"
            in
                ( model, Cmd.batch [ Sharepoint.getJsonData Sharepoint.Edges, Sharepoint.getJsonData Sharepoint.Nodes ] )


displayModel : Model -> ( Model, Cmd Msg )
displayModel model =
    let
        currentPath =
            getCurrentFocus model.graph <|
                "VISION"

        state : State
        state =
            if model.state == Error then
                Error
            else if length model.graph.nodes == 0 || length model.graph.edges == 0 then
                Loading
            else
                Ready

        newModel =
            { model
                | state = state
                , currentPath = Graph.filterGraph model.graph currentPath
            }
    in
        ( newModel, JsGraph.tree newModel.currentPath )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ JsGraph.selectNode Msg.ChangeSelection
        , JsGraph.showNode Msg.ShowDescription
        , Keyboard.downs Msg.KeyMsg
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.h1 [] [ text "The Graph" ]
        , renderNetwork model

        --, button [ onClick Msg.MorePlease ] [ text "hit the server!" ]
        ]


loadingAnimation : Model -> Html Msg
loadingAnimation model =
    let
        gif name =
            div [ class ("state " ++ name) ] []
    in
        case model.state of
            Loading ->
                gif "loading"

            Error ->
                gif "error"

            Ready ->
                text ""


renderNetwork : Model -> Html Msg
renderNetwork model =
    div [ class "project-container" ]
        [ loadingAnimation model
        , div [ id "network" ] []
        , renderLongdescription model.graph model.showDescription
        ]


renderLongdescription : Graph -> Maybe String -> Html Msg
renderLongdescription graph maybeNodeId =
    case maybeNodeId of
        Maybe.Nothing ->
            Html.text ""

        Maybe.Just node ->
            Graph.findNodeById graph node
                |> renderLongdescriptionOfNode


renderLongdescriptionOfNode : Maybe Node -> Html Msg
renderLongdescriptionOfNode maybeNode =
    case maybeNode of
        Maybe.Nothing ->
            Html.text ""

        Maybe.Just node ->
            Html.div [ class "background", onClick Msg.HideDescription ]
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
