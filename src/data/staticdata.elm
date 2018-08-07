module StaticData exposing (projects, connections, Node, Edge)


type alias Node =
    { id : String
    , name : String
    , description : Maybe String
    , year : Maybe Int
    , projectmanager : List String
    , responsiblemanager : List String
    , teammember : List String
    }


type alias Edge =
    { from : String
    , to : String
    , edgetype : Maybe String
    }


projects : List Node
projects =
    [ { id = "NC1", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC2", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC3", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC4", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC5", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC6", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC7", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC8", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC9", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC10", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC11", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC12", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC13", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC14", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC15", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC16", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC17", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC18", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC19", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC20", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC23", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC24", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC25", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC26", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC27", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC28", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC29", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC30", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC31", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC32", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC33", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC35", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC36", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC37", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC38", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC39", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC40", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC41", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC42", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "NC43", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF1", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF2", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF3", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF4", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF5", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF6", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF7", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF8", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF9", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF10", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF11", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF12", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF13", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF14", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF15", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF16", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF17", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF18", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF19", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF20", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF21", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF22", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF23", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "CSF24", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "SO1", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "SO2", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "SO3", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "SO4", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "SO5", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "SO6", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    , { id = "VISION", name = "???", description = Maybe.Just "mysterious node", year = Maybe.Nothing, projectmanager = [], responsiblemanager = [], teammember = [] }
    ]


connections : List Edge
connections =
    [ { from = "NC1", to = "CSF1", edgetype = Maybe.Nothing }
    , { from = "NC1", to = "CSF2", edgetype = Maybe.Nothing }
    , { from = "NC2", to = "CSF1", edgetype = Maybe.Nothing }
    , { from = "NC2", to = "CSF2", edgetype = Maybe.Nothing }
    , { from = "NC2", to = "CSF12", edgetype = Maybe.Nothing }
    , { from = "NC2", to = "CSF19", edgetype = Maybe.Nothing }
    , { from = "NC3", to = "CSF1", edgetype = Maybe.Nothing }
    , { from = "NC3", to = "CSF3", edgetype = Maybe.Nothing }
    , { from = "NC3", to = "CSF18", edgetype = Maybe.Nothing }
    , { from = "NC3", to = "CSF20", edgetype = Maybe.Nothing }
    , { from = "NC4", to = "CSF5", edgetype = Maybe.Nothing }
    , { from = "NC4", to = "CSF14", edgetype = Maybe.Nothing }
    , { from = "NC4", to = "CSF16", edgetype = Maybe.Nothing }
    , { from = "NC4", to = "CSF19", edgetype = Maybe.Nothing }
    , { from = "NC4", to = "CSF21", edgetype = Maybe.Nothing }
    , { from = "NC4", to = "CSF22", edgetype = Maybe.Nothing }
    , { from = "NC5", to = "CSF1", edgetype = Maybe.Nothing }
    , { from = "NC5", to = "CSF2", edgetype = Maybe.Nothing }
    , { from = "NC5", to = "CSF6", edgetype = Maybe.Nothing }
    , { from = "NC5", to = "CSF7", edgetype = Maybe.Nothing }
    , { from = "NC5", to = "CSF12", edgetype = Maybe.Nothing }
    , { from = "NC5", to = "CSF13", edgetype = Maybe.Nothing }
    , { from = "NC5", to = "CSF17", edgetype = Maybe.Nothing }
    , { from = "NC6", to = "CSF4", edgetype = Maybe.Nothing }
    , { from = "NC6", to = "CSF7", edgetype = Maybe.Nothing }
    , { from = "NC7", to = "CSF7", edgetype = Maybe.Nothing }
    , { from = "NC8", to = "CSF7", edgetype = Maybe.Nothing }
    , { from = "NC9", to = "CSF4", edgetype = Maybe.Nothing }
    , { from = "NC9", to = "CSF8", edgetype = Maybe.Nothing }
    , { from = "NC10", to = "CSF7", edgetype = Maybe.Nothing }
    , { from = "NC10", to = "CSF13", edgetype = Maybe.Nothing }
    , { from = "NC10", to = "CSF14", edgetype = Maybe.Nothing }
    , { from = "NC10", to = "CSF18", edgetype = Maybe.Nothing }
    , { from = "NC11", to = "CSF4", edgetype = Maybe.Nothing }
    , { from = "NC11", to = "CSF16", edgetype = Maybe.Nothing }
    , { from = "NC11", to = "CSF19", edgetype = Maybe.Nothing }
    , { from = "NC12", to = "CSF9", edgetype = Maybe.Nothing }
    , { from = "NC12", to = "CSF17", edgetype = Maybe.Nothing }
    , { from = "NC13", to = "CSF9", edgetype = Maybe.Nothing }
    , { from = "NC14", to = "CSF10", edgetype = Maybe.Nothing }
    , { from = "NC15", to = "CSF10", edgetype = Maybe.Nothing }
    , { from = "NC16", to = "CSF10", edgetype = Maybe.Nothing }
    , { from = "NC17", to = "CSF10", edgetype = Maybe.Nothing }
    , { from = "NC18", to = "CSF10", edgetype = Maybe.Nothing }
    , { from = "NC19", to = "CSF11", edgetype = Maybe.Nothing }
    , { from = "NC19", to = "CSF12", edgetype = Maybe.Nothing }
    , { from = "NC20", to = "CSF11", edgetype = Maybe.Nothing }
    , { from = "NC20", to = "CSF12", edgetype = Maybe.Nothing }
    , { from = "NC23", to = "CSF13", edgetype = Maybe.Nothing }
    , { from = "NC24", to = "CSF13", edgetype = Maybe.Nothing }
    , { from = "NC24", to = "CSF14", edgetype = Maybe.Nothing }
    , { from = "NC25", to = "CSF2", edgetype = Maybe.Nothing }
    , { from = "NC25", to = "CSF14", edgetype = Maybe.Nothing }
    , { from = "NC26", to = "CSF2", edgetype = Maybe.Nothing }
    , { from = "NC26", to = "CSF14", edgetype = Maybe.Nothing }
    , { from = "NC27", to = "CSF13", edgetype = Maybe.Nothing }
    , { from = "NC27", to = "CSF15", edgetype = Maybe.Nothing }
    , { from = "NC28", to = "CSF15", edgetype = Maybe.Nothing }
    , { from = "NC29", to = "CSF17", edgetype = Maybe.Nothing }
    , { from = "NC30", to = "CSF1", edgetype = Maybe.Nothing }
    , { from = "NC30", to = "CSF3", edgetype = Maybe.Nothing }
    , { from = "NC30", to = "CSF17", edgetype = Maybe.Nothing }
    , { from = "NC31", to = "CSF17", edgetype = Maybe.Nothing }
    , { from = "NC32", to = "CSF4", edgetype = Maybe.Nothing }
    , { from = "NC32", to = "CSF16", edgetype = Maybe.Nothing }
    , { from = "NC32", to = "CSF18", edgetype = Maybe.Nothing }
    , { from = "NC33", to = "CSF18", edgetype = Maybe.Nothing }
    , { from = "NC35", to = "CSF19", edgetype = Maybe.Nothing }
    , { from = "NC35", to = "CSF21", edgetype = Maybe.Nothing }
    , { from = "NC36", to = "CSF19", edgetype = Maybe.Nothing }
    , { from = "NC36", to = "CSF20", edgetype = Maybe.Nothing }
    , { from = "NC36", to = "CSF21", edgetype = Maybe.Nothing }
    , { from = "NC36", to = "CSF23", edgetype = Maybe.Nothing }
    , { from = "NC37", to = "CSF20", edgetype = Maybe.Nothing }
    , { from = "NC38", to = "CSF19", edgetype = Maybe.Nothing }
    , { from = "NC38", to = "CSF20", edgetype = Maybe.Nothing }
    , { from = "NC38", to = "CSF21", edgetype = Maybe.Nothing }
    , { from = "NC39", to = "CSF19", edgetype = Maybe.Nothing }
    , { from = "NC40", to = "CSF22", edgetype = Maybe.Nothing }
    , { from = "NC41", to = "CSF22", edgetype = Maybe.Nothing }
    , { from = "NC42", to = "CSF22", edgetype = Maybe.Nothing }
    , { from = "NC43", to = "CSF22", edgetype = Maybe.Nothing }
    , { from = "NC44", to = "CSF19", edgetype = Maybe.Nothing }
    , { from = "NC44", to = "CSF23", edgetype = Maybe.Nothing }
    , { from = "NC44", to = "CSF24", edgetype = Maybe.Nothing }
    , { from = "CSF1", to = "SO1", edgetype = Maybe.Nothing }
    , { from = "CSF2", to = "SO1", edgetype = Maybe.Nothing }
    , { from = "CSF3", to = "SO1", edgetype = Maybe.Nothing }
    , { from = "CSF4", to = "SO1", edgetype = Maybe.Nothing }
    , { from = "CSF5", to = "SO1", edgetype = Maybe.Nothing }
    , { from = "CSF6", to = "SO2", edgetype = Maybe.Nothing }
    , { from = "CSF7", to = "SO2", edgetype = Maybe.Nothing }
    , { from = "CSF8", to = "SO2", edgetype = Maybe.Nothing }
    , { from = "CSF9", to = "SO2", edgetype = Maybe.Nothing }
    , { from = "CSF10", to = "SO1", edgetype = Maybe.Nothing }
    , { from = "CSF10", to = "SO2", edgetype = Maybe.Nothing }
    , { from = "CSF10", to = "SO3", edgetype = Maybe.Nothing }
    , { from = "CSF10", to = "SO4", edgetype = Maybe.Nothing }
    , { from = "CSF10", to = "SO5", edgetype = Maybe.Nothing }
    , { from = "CSF10", to = "SO6", edgetype = Maybe.Nothing }
    , { from = "CSF11", to = "SO3", edgetype = Maybe.Nothing }
    , { from = "CSF12", to = "SO3", edgetype = Maybe.Nothing }
    , { from = "CSF13", to = "SO4", edgetype = Maybe.Nothing }
    , { from = "CSF14", to = "SO4", edgetype = Maybe.Nothing }
    , { from = "CSF15", to = "SO4", edgetype = Maybe.Nothing }
    , { from = "CSF16", to = "SO5", edgetype = Maybe.Nothing }
    , { from = "CSF17", to = "SO5", edgetype = Maybe.Nothing }
    , { from = "CSF18", to = "SO5", edgetype = Maybe.Nothing }
    , { from = "CSF19", to = "SO6", edgetype = Maybe.Nothing }
    , { from = "CSF20", to = "SO6", edgetype = Maybe.Nothing }
    , { from = "CSF21", to = "SO6", edgetype = Maybe.Nothing }
    , { from = "CSF22", to = "SO6", edgetype = Maybe.Nothing }
    , { from = "CSF23", to = "SO6", edgetype = Maybe.Nothing }
    , { from = "CSF24", to = "SO6", edgetype = Maybe.Nothing }
    , { from = "SO1", to = "VISION", edgetype = Maybe.Nothing }
    , { from = "SO2", to = "VISION", edgetype = Maybe.Nothing }
    , { from = "SO3", to = "VISION", edgetype = Maybe.Nothing }
    , { from = "SO4", to = "VISION", edgetype = Maybe.Nothing }
    , { from = "SO5", to = "VISION", edgetype = Maybe.Nothing }
    , { from = "SO6", to = "VISION", edgetype = Maybe.Nothing }
    ]
