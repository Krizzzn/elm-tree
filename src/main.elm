module Main exposing (..)

import List exposing (..)
import StaticData exposing (..)
import Graph exposing (..)
import SvgGraph exposing (..)
import JsGraph exposing (..)
import Navigation
import Keyboard
import Msg exposing (Msg)
import Sharepoint
import Date exposing (now, year)
import Task exposing (Task)
import Model exposing (State(..), Search, Year, Model, defaultModel)
import View exposing (view)
import SearchView exposing (renderSearch, limitSearchResult, sortedNodes)


main =
    Navigation.program Msg.UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( defaultModel location
    , Cmd.batch
        [ Task.perform Msg.CurrentYear Date.now
        , Sharepoint.getJsonData Sharepoint.Edges
        , Sharepoint.getJsonData Sharepoint.Nodes
        ]
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        search =
            model.search

        modelyear =
            model.year
    in
        case msg of
            Msg.ChangeSelection newSelection ->
                let
                    m =
                        model.location

                    location =
                        { m | hash = "#" ++ newSelection }
                in
                    ( model, Navigation.newUrl (location.pathname ++ location.hash) )

            Msg.UrlChange location ->
                let
                    newModel =
                        { model
                            | location = location
                            , showDescription = Maybe.Nothing
                            , displayImage = True
                        }
                in
                    displayModel newModel

            Msg.ShowDescription nodeId ->
                if (model.highlightNode == Maybe.Just nodeId) then
                    ( { model | showDescription = Maybe.Just nodeId }, Cmd.none )
                else
                    ( { model | highlightNode = Maybe.Just nodeId }, Cmd.none )

            Msg.HideDescription ->
                ( { model | showDescription = Maybe.Nothing, highlightNode = Maybe.Nothing, displayImage = True }, Cmd.none )

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
                        ( { model | showDescription = Maybe.Nothing, displayImage = True, highlightNode = Maybe.Nothing, search = { search | searchString = "", projects = [], highlight = 0, searchPrefix = "" } }, Cmd.none )

                    ( 38, _, _ ) ->
                        ( { model | search = { search | highlight = (Basics.max 0 (search.highlight - 1)) } }, Cmd.none )

                    ( 40, _, _ ) ->
                        ( { model | search = { search | highlight = (Basics.min limitSearchResult (search.highlight + 1)) } }, Cmd.none )

                    ( _, _, _ ) ->
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

            Msg.ChangeYear year ->
                let
                    newmodel =
                        { model | year = { modelyear | highlight = year } }
                in
                    displayModel newmodel

            Msg.CurrentYear date ->
                let
                    y =
                        (Basics.min (year date + 1) 2019)
                in
                    ( { model | year = { modelyear | current = y, highlight = Maybe.Just y } }, Cmd.none )

            Msg.FocusYear focus ->
                let
                    newmodel =
                        { model | year = { modelyear | focus = focus } }
                in
                    displayModel newmodel

            Msg.HeroImageError ->
                ( { model | displayImage = False }, Cmd.none )

            Msg.DoNothing ->
                ( model, Cmd.none )


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
                , currentPath = prepareView model currentPath
            }
    in
        case state of
            Ready ->
                ( newModel, JsGraph.tree newModel.currentPath )

            _ ->
                ( newModel, Cmd.none )


prepareView : Model -> String -> Graph
prepareView model currentPath =
    Graph.filterGraph currentPath model.graph
        |> Graph.highlightYear model.year.highlight
        |> if model.year.focus then
            Graph.filter (\n -> n.year == model.year.highlight)
           else
            (\g -> g)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ JsGraph.selectNode Msg.ChangeSelection
        , JsGraph.showNode Msg.ShowDescription
        , Keyboard.downs Msg.KeyMsg
        ]



-- VIEW
-- body


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
