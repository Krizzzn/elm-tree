module Sharepoint exposing (..)

import Http
import Msg exposing (Msg)
import Json.Decode as JD exposing (field, Decoder, int, string)
import ModelBase exposing (Edge, Node)
import Config exposing (local)
import Regex exposing (split)


type Query
    = Edges
    | Nodes


getEndpointUrl : String -> String
getEndpointUrl service =
    if local then
        "json/" ++ service ++ ".json"
    else
        "/_vti_bin/listdata.svc/" ++ service


getImageUrl : String -> String
getImageUrl nodeId =
    if local then
        "json/hero/" ++ nodeId ++ ".jpg"
    else
        "/" ++ nodeId ++ ".jpg"


getServiceUrl : Query -> String
getServiceUrl q =
    case q of
        Edges ->
            getEndpointUrl "VisionGraphEdges"

        Nodes ->
            getEndpointUrl "VisionGraphNodes"


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
    JD.map7 Node
        (JD.at [ "NodeId" ] string)
        (JD.at [ "Name" ] string)
        (JD.maybe <| JD.at [ "Longdescription" ] string)
        (JD.maybe <| JD.at [ "FiscalYear" ] int)
        (JD.at [ "ProjectManager" ] people)
        (JD.at [ "ResponsibleManager" ] people)
        (JD.at [ "TeamMember" ] people)


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
