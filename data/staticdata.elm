module StaticData exposing (projects, connections, Node, Edge)


type alias Node =
    { id : String
    , name : String
    , description : Maybe String
    }


type alias Edge =
    { from : String
    , to : String
    }


projects : List Node
projects =
    [ { id = "NC1", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC2", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC3", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC4", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC5", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC6", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC7", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC8", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC9", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC10", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC11", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC12", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC13", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC14", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC15", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC16", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC17", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC18", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC19", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC20", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC23", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC24", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC25", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC26", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC27", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC28", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC29", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC30", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC31", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC32", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC33", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC35", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC36", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC37", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC38", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC39", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC40", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC41", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC42", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "NC43", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF1", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF2", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF3", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF4", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF5", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF6", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF7", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF8", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF9", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF10", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF11", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF12", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF13", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF14", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF15", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF16", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF17", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF18", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF19", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF20", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF21", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF22", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF23", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "CSF24", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "SO1", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "SO2", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "SO3", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "SO4", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "SO5", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "SO6", name = "???", description = Maybe.Just "mysterious node" }
    , { id = "VISION", name = "???", description = Maybe.Just "mysterious node" }
    ]


connections : List Edge
connections =
    [ { from = "NC1", to = "CSF1" }
    , { from = "NC1", to = "CSF2" }
    , { from = "NC2", to = "CSF1" }
    , { from = "NC2", to = "CSF2" }
    , { from = "NC2", to = "CSF12" }
    , { from = "NC2", to = "CSF19" }
    , { from = "NC3", to = "CSF1" }
    , { from = "NC3", to = "CSF3" }
    , { from = "NC3", to = "CSF18" }
    , { from = "NC3", to = "CSF20" }
    , { from = "NC4", to = "CSF5" }
    , { from = "NC4", to = "CSF14" }
    , { from = "NC4", to = "CSF16" }
    , { from = "NC4", to = "CSF19" }
    , { from = "NC4", to = "CSF21" }
    , { from = "NC4", to = "CSF22" }
    , { from = "NC5", to = "CSF1" }
    , { from = "NC5", to = "CSF2" }
    , { from = "NC5", to = "CSF6" }
    , { from = "NC5", to = "CSF7" }
    , { from = "NC5", to = "CSF12" }
    , { from = "NC5", to = "CSF13" }
    , { from = "NC5", to = "CSF17" }
    , { from = "NC6", to = "CSF4" }
    , { from = "NC6", to = "CSF7" }
    , { from = "NC7", to = "CSF7" }
    , { from = "NC8", to = "CSF7" }
    , { from = "NC9", to = "CSF4" }
    , { from = "NC9", to = "CSF8" }
    , { from = "NC10", to = "CSF7" }
    , { from = "NC10", to = "CSF13" }
    , { from = "NC10", to = "CSF14" }
    , { from = "NC10", to = "CSF18" }
    , { from = "NC11", to = "CSF4" }
    , { from = "NC11", to = "CSF16" }
    , { from = "NC11", to = "CSF19" }
    , { from = "NC12", to = "CSF9" }
    , { from = "NC12", to = "CSF17" }
    , { from = "NC13", to = "CSF9" }
    , { from = "NC14", to = "CSF10" }
    , { from = "NC15", to = "CSF10" }
    , { from = "NC16", to = "CSF10" }
    , { from = "NC17", to = "CSF10" }
    , { from = "NC18", to = "CSF10" }
    , { from = "NC19", to = "CSF11" }
    , { from = "NC19", to = "CSF12" }
    , { from = "NC20", to = "CSF11" }
    , { from = "NC20", to = "CSF12" }
    , { from = "NC23", to = "CSF13" }
    , { from = "NC24", to = "CSF13" }
    , { from = "NC24", to = "CSF14" }
    , { from = "NC25", to = "CSF2" }
    , { from = "NC25", to = "CSF14" }
    , { from = "NC26", to = "CSF2" }
    , { from = "NC26", to = "CSF14" }
    , { from = "NC27", to = "CSF13" }
    , { from = "NC27", to = "CSF15" }
    , { from = "NC28", to = "CSF15" }
    , { from = "NC29", to = "CSF17" }
    , { from = "NC30", to = "CSF1" }
    , { from = "NC30", to = "CSF3" }
    , { from = "NC30", to = "CSF17" }
    , { from = "NC31", to = "CSF17" }
    , { from = "NC32", to = "CSF4" }
    , { from = "NC32", to = "CSF16" }
    , { from = "NC32", to = "CSF18" }
    , { from = "NC33", to = "CSF18" }
    , { from = "NC35", to = "CSF19" }
    , { from = "NC35", to = "CSF21" }
    , { from = "NC36", to = "CSF19" }
    , { from = "NC36", to = "CSF20" }
    , { from = "NC36", to = "CSF21" }
    , { from = "NC36", to = "CSF23" }
    , { from = "NC37", to = "CSF20" }
    , { from = "NC38", to = "CSF19" }
    , { from = "NC38", to = "CSF20" }
    , { from = "NC38", to = "CSF21" }
    , { from = "NC39", to = "CSF19" }
    , { from = "NC40", to = "CSF22" }
    , { from = "NC41", to = "CSF22" }
    , { from = "NC42", to = "CSF22" }
    , { from = "NC43", to = "CSF22" }
    , { from = "NC44", to = "CSF19" }
    , { from = "NC44", to = "CSF23" }
    , { from = "NC44", to = "CSF24" }
    , { from = "CSF1", to = "SO1" }
    , { from = "CSF2", to = "SO1" }
    , { from = "CSF3", to = "SO1" }
    , { from = "CSF4", to = "SO1" }
    , { from = "CSF5", to = "SO1" }
    , { from = "CSF6", to = "SO2" }
    , { from = "CSF7", to = "SO2" }
    , { from = "CSF8", to = "SO2" }
    , { from = "CSF9", to = "SO2" }
    , { from = "CSF10", to = "SO1" }
    , { from = "CSF10", to = "SO2" }
    , { from = "CSF10", to = "SO3" }
    , { from = "CSF10", to = "SO4" }
    , { from = "CSF10", to = "SO5" }
    , { from = "CSF10", to = "SO6" }
    , { from = "CSF11", to = "SO3" }
    , { from = "CSF12", to = "SO3" }
    , { from = "CSF13", to = "SO4" }
    , { from = "CSF14", to = "SO4" }
    , { from = "CSF15", to = "SO4" }
    , { from = "CSF16", to = "SO5" }
    , { from = "CSF17", to = "SO5" }
    , { from = "CSF18", to = "SO5" }
    , { from = "CSF19", to = "SO6" }
    , { from = "CSF20", to = "SO6" }
    , { from = "CSF21", to = "SO6" }
    , { from = "CSF22", to = "SO6" }
    , { from = "CSF23", to = "SO6" }
    , { from = "CSF24", to = "SO6" }
    , { from = "SO1", to = "VISION" }
    , { from = "SO2", to = "VISION" }
    , { from = "SO3", to = "VISION" }
    , { from = "SO4", to = "VISION" }
    , { from = "SO5", to = "VISION" }
    , { from = "SO6", to = "VISION" }
    ]
