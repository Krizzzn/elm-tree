module Model exposing (State(..), Search, Year, Model, defaultModel)

import ModelBase exposing (Node)
import Navigation exposing (..)
import Graph exposing (..)


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


type alias Year =
    { focus : Bool
    , highlight : Maybe Int
    , current : Int
    }


type alias Model =
    { graph : Graph
    , location : Navigation.Location
    , currentPath : Graph
    , showDescription : Maybe String
    , highlightNode : Maybe String
    , year : Year
    , state : State
    , search : Search
    , displayImage : Bool
    }


defaultgraph : Graph
defaultgraph =
    { nodes = []
    , edges = []
    , filter = []
    }


defaultModel : Navigation.Location -> Model
defaultModel location =
    { graph = defaultgraph
    , location = location
    , currentPath = defaultgraph
    , showDescription = Maybe.Nothing
    , highlightNode = Maybe.Nothing
    , year =
        { focus = False
        , highlight = Maybe.Nothing
        , current = 2000
        }
    , state = Loading
    , search =
        { searchString = ""
        , projects = []
        , highlight = 0
        , searchPrefix = ""
        }
    , displayImage = True
    }
