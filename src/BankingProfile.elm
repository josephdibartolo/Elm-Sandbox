module BankingProfile exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

main =
  Browser.sandbox { init = init, update = update, view = view }


-- Model Alias and Initializer

type alias Model = 
    { name : String
    , balance : Maybe Int -- Zero-decimal amount.
    , curr : String -- ISO format.
    }

init : Model
init =
    Model "" Nothing "USD"

-- Update (Pattern Matching) Functions and Message Type Definition

type Msg
    = Name String
    | UpdateBalance

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        UpdateBalance ->
            ( case model.balance of
                Just value ->
                    { model | balance = Just (value * 2) }
            
                Nothing ->
                    { model | balance = Just 1 }
             )    

-- View Method

formatBalance : Maybe Int -> String -> String
formatBalance balance curr =
    case balance of
        Just value ->
            String.fromInt value ++ " " ++ curr
        Nothing ->
            "You're broke."
    

view : Model -> Html Msg
view model =
    div []
    [ viewInput "text" "Name" model.name Name
    , button [ onClick UpdateBalance ] [ text "Update" ]
    , div [] [ text (formatBalance model.balance model.curr) ]
    --     viewInput "text" "Name" model.name Name
    -- , viewInput "password" "Password" model.password Password
    -- , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    -- , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


-- viewValidation : Model -> Html msg
-- viewValidation model =
--   if model.password == model.passwordAgain &&
--    String.length model.password > 8 &&
--    String.any Char.isUpper model.password &&
--    String.any Char.isLower model.password &&
--    String.any Char.isDigit model.password then
--     div [ style "color" "green" ] [ text "OK" ]
--   else
--     div [ style "color" "red" ] [ text "Passwords do not match!" ]
    