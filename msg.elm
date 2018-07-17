module Msg exposing (..)

import StaticData exposing (Edge, Node)
import Navigation
import Keyboard
import Http


type Msg
    = ChangeSelection String
    | UrlChange Navigation.Location
    | ShowDescription String
    | HideDescription
    | DoNothing
    | KeyMsg Keyboard.KeyCode
    | EdgesLoaded (Result Http.Error (List Edge))
    | NodesLoaded (Result Http.Error (List Node))
    | Search String
