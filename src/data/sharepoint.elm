module Sharepoint exposing (..)

import Http
import Msg exposing (Msg)
import Json.Decode as JD exposing (field, Decoder, int, string)
import ModelBase exposing (Edge, Node)
import Config exposing (Environment(..), local, currentEnvironment)
import Regex exposing (split)
import DateArit exposing (floatToInternalYear)


type Query
    = Edges
    | Nodes


getEndpointUrl : String -> String
getEndpointUrl service =
    if local then
        "json/" ++ service ++ ".json"
    else
        site ++ "_vti_bin/listdata.svc/" ++ service


site : String
site =
    case currentEnvironment of
        Strategy ->
            ""

        TOC ->
            ""


getImageUrl : String -> String
getImageUrl nodeId =
    if local then
        "json/hero/" ++ nodeId ++ ".jpg"
    else
        "/" ++ nodeId ++ ".jpg"


getServiceUrl : Query -> String
getServiceUrl q =
    case ( q, currentEnvironment ) of
        ( Edges, Strategy ) ->
            getEndpointUrl "VisionGraphEdges"

        ( Nodes, Strategy ) ->
            getEndpointUrl "VisionGraphNodes"

        ( Edges, TOC ) ->
            getEndpointUrl "TOCEdges"

        ( Nodes, TOC ) ->
            getEndpointUrl "TOCNodes"


getJsonRequest : String -> Decoder a -> Http.Request a
getJsonRequest url decoder =
    Http.request
        { method = "GET"
        , headers =
            [ Http.header "accept" "application/json"
            ]
        , url = url
        , body = Http.emptyBody
        , expect = Http.expectJson decoder
        , timeout = Nothing
        , withCredentials = True
        }


getJsonData : Query -> Cmd Msg
getJsonData q =
    let
        url =
            getServiceUrl q
    in
        case q of
            Edges ->
                Http.send Msg.EdgesLoaded <| getJsonRequest url decodeEdges

            Nodes ->
                -- here needs to be some foo
                Http.send Msg.NodesLoaded <| getJsonRequest url decodeNodes


decodeNode : JD.Decoder Node
decodeNode =
    case currentEnvironment of
        Strategy ->
            JD.map8 Node
                (JD.at [ "NodeId" ] string)
                (JD.at [ "Name" ] string)
                (JD.maybe <| JD.at [ "Longdescription" ] string)
                (JD.maybe <| JD.at [ "FiscalYear" ] JD.int)
                (JD.at [ "Progress" ] progress)
                (JD.at [ "ProjectManager" ] people)
                (JD.at [ "ResponsibleManager" ] people)
                (JD.at [ "TeamMember" ] people)

        TOC ->
            JD.map8 Node
                (JD.at [ "NodeId" ] string)
                (JD.at [ "Name" ] string)
                (JD.maybe <| JD.at [ "Longdescription" ] string)
                (JD.at [ "YearQuarter" ] year)
                (JD.at [ "Name" ] progress)
                (JD.at [ "Name" ] people)
                (JD.at [ "Name" ] people)
                (JD.at [ "Name" ] people)


people : Decoder (List String)
people =
    let
        convert : Maybe String -> Decoder (List String)
        convert raw =
            case raw of
                Just value ->
                    JD.succeed <|
                        List.filter (\e -> String.length e > 0) <|
                            List.map String.trim <|
                                split Regex.All (Regex.regex ",|;") value

                Nothing ->
                    JD.succeed []
    in
        string |> JD.maybe |> JD.andThen convert


progress : Decoder (Maybe Int)
progress =
    let
        convert : Maybe Float -> Decoder (Maybe Int)
        convert raw =
            case raw of
                Just value ->
                    JD.succeed <| Maybe.Just <| floor <| value * 100

                Nothing ->
                    JD.succeed Maybe.Nothing
    in
        JD.float |> JD.maybe |> JD.andThen convert


year : Decoder (Maybe Int)
year =
    let
        convert : Maybe Float -> Decoder (Maybe Int)
        convert raw =
            case raw of
                Just value ->
                    JD.succeed <| Maybe.Just <| DateArit.floatToInternalYear <| value

                Nothing ->
                    JD.succeed Maybe.Nothing
    in
        JD.float |> JD.maybe |> JD.andThen convert


decodeEdge : JD.Decoder Edge
decodeEdge =
    JD.map3 Edge
        (JD.at [ "From" ] string)
        (JD.at [ "To" ] string)
        (JD.maybe <| JD.at [ "EdgeTypeValue" ] string)


decodeEnvelope : JD.Decoder a -> JD.Decoder a
decodeEnvelope =
    JD.at [ "d", "results" ]


decodeEdges : JD.Decoder (List Edge)
decodeEdges =
    decodeEnvelope <| JD.list <| decodeEdge


decodeNodes : JD.Decoder (List Node)
decodeNodes =
    decodeEnvelope <| JD.list <| decodeNode
