module Wayfinder exposing (traverse, flatten)

import StaticData exposing (..)


type Path
    = Path
        {
        path : List Edge
        , sub : List Path
        }

-- traverses the path and returns only paths that move throu the POIs
traverse : Edge -> List Edge -> Path
traverse fromTo edges =
    let
        category = String.left 2 fromTo.to

        a = List.filter (\e -> ((not (String.startsWith category e.to)) || e.to == fromTo.to ) )
            <| List.filter (\e -> (e.from == fromTo.from ) )
            <| edges

        found = List.any (\e -> e.to == fromTo.to) a
        empty = List.length a == 0

    in
        case (found, empty) of
            (False, False) ->
                Path {
                     path = a
                    , sub = List.map (\e -> traverse { from = e.to, to = fromTo.to } edges) a
                    }

            (True, False) ->
                Path {
                     path = a
                    , sub = []
                    }

            (_, _) ->
                Path {
                     path = []
                    , sub = []
                    }

-- flatten a path
flatten : Path -> List Edge
flatten path =
    []