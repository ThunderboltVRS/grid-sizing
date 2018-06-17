module Types exposing (..)

import Material


type Msg
    = ChangeColumnWidth Int String
    | AddColumn
    | RemoveColumn Int
    | RenameColumn Int String
    | Mdl (Material.Msg Msg)


type alias Model =
    { totalWidth : Int
    , columns : List Column
    , idSeed : Int
    , mdl : Material.Model
    }


type alias Column =
    { id : Int
    , name : String
    , width : Int
    }
