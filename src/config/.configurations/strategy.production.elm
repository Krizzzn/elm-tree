module Config exposing (..)


type Environment
    = Strategy
    | TOC


currentEnvironment : Environment
currentEnvironment =
    Strategy


local : Bool
local =
    False


rootNode : String
rootNode =
    "VISION"


head : String
head =
    "Strategy"
