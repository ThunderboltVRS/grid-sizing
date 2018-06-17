module States exposing (..)

import Types exposing (..)
import Material

initialModel : ( Model, Cmd Msg )
initialModel =
    ( defaultModel, Cmd.none )


defaultModel : Model
defaultModel =
    { totalWidth = 5
    , columns = [ itemImageColumn, emptyColumn 1, emptyColumn 2, emptyColumn 3, emptyColumn 4, emptyColumn 5, emptyColumn 6, emptyColumn 7, emptyColumn 8, emptyColumn 9 ]
    , mdl = Material.model
    , idSeed = 10
    }

itemImageColumn : Column
itemImageColumn =
    { id = 0
    , name = "Item Image"
    , width = 4
    }

emptyColumn : Int -> Column
emptyColumn columnId =
    { id = columnId
    , name = ""
    , width = 0
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
