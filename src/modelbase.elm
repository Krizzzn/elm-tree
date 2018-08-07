module ModelBase exposing (Node, Edge)


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
