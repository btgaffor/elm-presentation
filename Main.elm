module Main exposing (..)

import Html exposing (Html, Attribute, program, div, span, input, text, h1, code, pre, br)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- Model --

-- type Maybe x = Just x
--              | Nothing

maybePrint : Maybe String -> String
maybePrint str =
  case str of
    Just str -> str
    Nothing -> "please enter a string!"

printDefault : Maybe String -> String
printDefault str =
  "Your string was " ++ (Maybe.withDefault "not given!" str)

-- type Result x = Ok x
--               | Error String

type alias Model =
  {
    firstName: String,
    lastName: String,
    age: String
  }

model : Model
model =
  {
    firstName = "Joe",
    lastName = "Schmoe",
    age = "17"
  }

init: (Model, Cmd Action)
init = (model, Cmd.none)

-- Update --

type Action = SetFirstName String
            | SetLastName String
            | SetAge String

update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    SetFirstName newFirstName -> ({ model | firstName = newFirstName }, Cmd.none)
    SetLastName newLastName -> ({ model | lastName = newLastName }, Cmd.none)
    SetAge newAge -> ({ model | age = newAge }, Cmd.none)

-- View --

view : Model -> Html Action
view model =
  div []
    [ div []
        [ input [ onInput SetFirstName, value model.firstName ] []
        , input [ onInput SetLastName, value model.lastName ] []
        , input [ onInput SetAge, value model.age ] []
        ]
    , (ageTest model)
    ]

ageTest : Model -> Html Action
ageTest model =
  case (String.toInt model.age) of
    Ok age ->
      if (age >= 21) then
        span [] [ text ((name model) ++ " " ++ "can drink responsibly") ]
      else
        span [] [ text ((name model) ++ " " ++ "will have a mocktail") ]
    Err error ->
      span [] [ text error ]

name : Model -> String
name model =
  model.firstName ++ " " ++ model.lastName

-- Main --

main : Program Never Model Action
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }
