module Config exposing (..)


type Environment
    = Strategy
    | TOC


currentEnvironment : Environment
currentEnvironment =
    Strategy


local : Bool
local =
    True


rootNode : String
rootNode =
    "VISION"


head : String
head =
    "Strategy"
