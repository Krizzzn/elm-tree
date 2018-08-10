module Config exposing (..)


type Environment
    = Strategy
    | TOC


currentEnvironment : Environment
currentEnvironment =
    TOC


local : Bool
local =
    False


rootNode : String
rootNode =
    "TEST1"


head : String
head =
    "Road"
