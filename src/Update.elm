module Update exposing (..)

import Types exposing (..)
import Material


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RenameColumn columnId newName ->
            ( (renameColumn model columnId newName), Cmd.none )

        RemoveColumn columnId ->
            ( (removeColumn model columnId) |> updateTotalWidth, Cmd.none )

        AddColumn ->
            ( (addColumn model), Cmd.none )

        ChangeColumnWidth columnId newWidth ->
            ( (changeWidth model columnId newWidth) |> updateTotalWidth, Cmd.none )

        Types.Mdl msg ->
            Material.update Mdl msg model


addColumn : Model -> Model
addColumn model =
    { model | columns = List.append model.columns [ newColumn model ], idSeed = model.idSeed + 1 }


removeColumn : Model -> Int -> Model
removeColumn model columnId =
    { model | columns = List.filter (\c -> c.id /= columnId) model.columns }


renameColumn : Model -> Int -> String -> Model
renameColumn model columnId newName =
    { model
        | columns =
            List.map
                (\c ->
                    if c.id == columnId then
                        { c | name = newName }
                    else
                        c
                )
                model.columns
    }


changeWidth : Model -> Int -> String -> Model
changeWidth model columnId newWidthString =
    { model
        | columns =
            List.map
                (\c ->
                    if c.id == columnId then
                        { c | width = if newWidthString == "" then 0 else (Result.withDefault c.width (String.toInt newWidthString)) }
                    else
                        c
                )
                model.columns
    }


newColumn : Model -> Column
newColumn model =
    { id = model.idSeed
    , name = ""
    , width = 0
    }

updateTotalWidth : Model -> Model
updateTotalWidth model =
    {model | totalWidth = List.sum (List.map (\c -> c.width) model.columns)}
