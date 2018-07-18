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


type alias Search =
    { searchString : String
    , projects : List Node
    , highlight : Int
    , searchPrefix : String
    }


type alias Model =
    { graph : Graph
    , location : Navigation.Location
    , currentPath : Graph
    , showDescription : Maybe String
    , highlightNode : Maybe String
    , state : State
    , search : Search
    }


limitSearchResult : Int
limitSearchResult =
    50


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
            , highlightNode = Maybe.Nothing
            , state = Loading
            , search =
                { searchString = ""
                , projects = []
                , highlight = 0
                , searchPrefix = ""
                }
            }
    in
        ( default, Cmd.batch [ Sharepoint.getJsonData Sharepoint.Edges, Sharepoint.getJsonData Sharepoint.Nodes ] )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        search =
            model.search
    in
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
                        { model
                            | location = location
                            , currentPath = Graph.filterGraph model.graph newSelection
                            , showDescription = Maybe.Nothing
                        }
                in
                    ( newModel, JsGraph.tree newModel.currentPath )

            Msg.ShowDescription nodeId ->
                if (model.highlightNode == Maybe.Just nodeId) then
                    ( { model | showDescription = Maybe.Just nodeId }, Cmd.none )
                else
                    ( { model | highlightNode = Maybe.Just nodeId }, Cmd.none )

            Msg.HideDescription ->
                ( { model | showDescription = Maybe.Nothing, highlightNode = Maybe.Nothing }, Cmd.none )

            Msg.KeyMsg code ->
                case ( code, search.highlight, List.length search.projects ) of
                    ( 13, _, 1 ) ->
                        case List.head search.projects of
                            Just project ->
                                update (Msg.ChangeSelection project.id) model

                            Nothing ->
                                update (Msg.DoNothing) model

                    ( 13, 0, _ ) ->
                        update (Msg.DoNothing) model

                    ( 13, _, _ ) ->
                        let
                            selected =
                                List.head <|
                                    List.drop (search.highlight - 1) <|
                                        sortedNodes search.projects
                        in
                            case selected of
                                Just sel ->
                                    update (Msg.ChangeSelection sel.id) model

                                Nothing ->
                                    update (Msg.DoNothing) model

                    ( 27, _, _ ) ->
                        ( { model | showDescription = Maybe.Nothing, highlightNode = Maybe.Nothing, search = { search | searchString = "", projects = [], highlight = 0, searchPrefix = "" } }, Cmd.none )

                    ( 38, _, _ ) ->
                        ( { model | search = { search | highlight = (Basics.max 0 (search.highlight - 1)) } }, Cmd.none )

                    ( 40, _, _ ) ->
                        ( { model | search = { search | highlight = (Basics.min limitSearchResult (search.highlight + 1)) } }, Cmd.none )

                    ( _, _, _ ) ->
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

            Msg.Search find ->
                let
                    s =
                        { search | searchString = find, highlight = 0 }
                in
                    ( { model | search = { s | projects = filterProjects s model.graph } }, Cmd.none )

            Msg.SearchPrefix find ->
                update (Msg.Search search.searchString) <| { model | search = { search | searchPrefix = find } }


filterProjects : Search -> Graph -> List Node
filterProjects search graph =
    Graph.findNodesByString (search.searchString) <|
        Graph.findNodesById graph search.searchPrefix


displayModel : Model -> ( Model, Cmd Msg )
displayModel model =
    let
        currentPath =
            getCurrentFocus model.graph <|
                String.dropLeft 1 model.location.hash

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
    div [ id "container" ]
        [ renderNetwork model
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
        , renderSearch model
        ]


renderSearch : Model -> Html Msg
renderSearch model =
    div [ id "search" ]
        [ input [ onInput Msg.Search, value model.search.searchString, placeholder "filter" ] []
        , renderChoices model.search.searchPrefix
        , renderSearchResult model.search
        ]


renderChoices : String -> Html Msg
renderChoices selected =
    let
        selectedClass b =
            if selected == b then
                "selected"
            else
                ""
    in
        div [ id "choice" ] <|
            List.map
                (\( lbl, val ) -> a [ onClick (Msg.SearchPrefix val), class (selectedClass val) ] [ text lbl ])
                [ ( "SO", "SO" )
                , ( "CSF", "CSF" )
                , ( "NC", "NC" )
                , ( "PRJ", "PRJ" )
                , ( "all", "" )
                ]


renderSearchResult : Search -> Html Msg
renderSearchResult search =
    if List.length search.projects > 0 then
        ul [ class "shown" ] <|
            List.indexedMap (renderNodeInFinder search.highlight) <|
                sortedNodes search.projects
    else
        text ""


sortedNodes : List Node -> List Node
sortedNodes nodes =
    List.take limitSearchResult <|
        List.sortBy (\node -> node.id) <|
            nodes


renderNodeInFinder : Int -> Int -> Node -> Html Msg
renderNodeInFinder selected idx node =
    let
        className =
            if selected == (idx + 1) then
                "selected"
            else
                ""
    in
        li [ class className ]
            [ a [ href ("#" ++ node.id) ] [ text ("[" ++ node.id ++ "] " ++ node.name) ]
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
            case node.description of
                Nothing ->
                    Html.text ""

                Just _ ->
                    Html.div [ class "background", onClick Msg.HideDescription ]
                        [ Markdown.toHtml [ class "content" ] (renderNodeAsMarkdown node)
                        ]


renderNodeAsMarkdown : Node -> String
renderNodeAsMarkdown node =
    let
        longdescription : String
        longdescription =
            case node.description of
                Just ld ->
                    ld

                Nothing ->
                    ""
    in
        "# [" ++ node.id ++ "] " ++ node.name ++ "\x0D\n" ++ longdescription



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
