port module JsGraph exposing (..)

import Graph exposing (..)


port tree : Graph -> Cmd msg


port haywireMode : Graph -> Cmd msg


port selectNode : (String -> msg) -> Sub msg


port showNode : (String -> msg) -> Sub msg
