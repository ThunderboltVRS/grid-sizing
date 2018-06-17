module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)
import Material.List as Lists
import Material.Options as Options exposing (when, css)
import Material.Icon as Icon
import Material.Color as Color
import Material.Scheme
import Material.Color
import Material.Options exposing (Style, css)
import Material.Button as Button
import Material.Typography as Typography
import Material.Textfield as Textfield
import Material.Layout as Layout
import Regex


view : Model -> Html Msg
view model =
    display model


display : Model -> Html Msg
display model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        ]
        { header =
            [ div []
                [ div [ Html.Attributes.style [ ( "float", "left" ), ( "padding", "10px" ), ( "width", "400px" ) ] ]
                    [ Options.styled p
                        [ Typography.display2 ]
                        [ text ("Total Width: " ++ (toString model.totalWidth)) ]
                    ]
                , div [ Html.Attributes.style [ ( "float", "left" ), ( "padding-top", "15px" ) ] ]
                    [ Button.render Mdl
                        [ 0 ]
                        model.mdl
                        [ Button.raised
                        , Button.colored
                        , Options.onClick AddColumn
                        ]
                        [ text "Add Column" ]
                    ]
                ]
            ]
        , drawer = []
        , tabs = ( [], [] )
        , main =
            [ generatedDivs model
            , div
                [ Html.Attributes.style [ ( "clear", "both" ) ] ]
                (listItems model)
            ]
        }
        |> Material.Scheme.topWithScheme Material.Color.Blue Material.Color.LightBlue


listItems : Model -> List (Html Msg)
listItems model =
    List.map (\c -> listItem model c) model.columns


listItem : Model -> Column -> Html Msg
listItem model column =
    Lists.li [ css "padding" "0px 0px 0px 10px" ] [ Lists.content [] [ listContent model column ] ]


rx : String
rx =
    "[0-9]*"


rx_ : Regex.Regex
rx_ =
    Regex.regex rx


match : String -> Regex.Regex -> Bool
match str rx =
    Regex.find Regex.All rx str
        |> List.any (.match >> (==) str)


listContent : Model -> Column -> Html Msg
listContent model column =
    div []
        [ div [ Html.Attributes.style [ ( "float", "left" ) ] ]
            [ Textfield.render Mdl
                [ column.id, 0 ]
                model.mdl
                [ Textfield.label "Name"
                , Textfield.text_
                , Textfield.value column.name
                , Options.onInput (RenameColumn column.id)
                ]
                []
            ]
        , div [ Html.Attributes.style [ ( "float", "left" ) ] ]
            [ Textfield.render Mdl
                [ column.id, 1 ]
                model.mdl
                [ Textfield.label "Width"
                , Textfield.value
                    (if column.width == 0 then
                        ""
                     else
                        (toString column.width)
                    )
                , Options.onInput (ChangeColumnWidth column.id)
                , css "margin" "0px 0px 0px 20px"
                ]
                []
            ]
        , div [ Html.Attributes.style [ ( "float", "left" ) ] ]
            [ Button.render Mdl
                [ column.id, 2 ]
                model.mdl
                [ Button.minifab
                , Button.colored
                , Options.onClick (RemoveColumn column.id)
                ]
                [ Icon.i "clear" ]
            ]
        ]


generatedDivs : Model -> Html Msg
generatedDivs model =
    div
        [ Html.Attributes.style
            [ ( "height", "48px" )
            , ( "padding-top", "2px" )
            ]
        ]
        (List.map (\c -> generatedDiv c) (List.filter (\c -> c.width /= 0) model.columns))


generatedDiv : Column -> Html msg
generatedDiv column =
    div
        [ Html.Attributes.style
            [ ( "float", "left" )
            , ( "width", ((toString (column.width)) ++ "%") )
            , ( "border-color", "grey" )
            , ( "border-style", "solid" )
            , ( "height", "30px" )
            , ( "border-width", "5px" )
            , ( "white-space", "nowrap" )
            , ( "overflow", "hidden" )
            , ( "text-overflow", "ellipsis" )
            , ( "box-sizing", "border-box" )
            ]
        ]
        [ Html.text column.name
        ]
