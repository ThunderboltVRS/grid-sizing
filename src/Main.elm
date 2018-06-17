module Main exposing (..)

import Html
import View exposing (..)
import States exposing (..)
import Update exposing (..)
import Types exposing (..)

main : Program Never Model Msg
main =
    Html.program
        { init = initialModel
        , subscriptions = subscriptions
        , update = update
        , view = View.view
        }