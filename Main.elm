import Html exposing (Html, Attribute, program, div, span, input, text, h1, code, pre, br)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- Model --

type alias Model =
  {
    firstName: String,
    lastName: String
  }

model : Model
model =
  {
    firstName = "Joe",
    lastName = "Schmoe"
  }

init: (Model, Cmd Action)
init = (model, Cmd.none)

-- Update --

type Action = SetFirstName String
            | SetLastName String

update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    SetFirstName newFirstName -> ({ model | firstName = newFirstName }, Cmd.none)
    SetLastName newLastName -> ({ model | lastName = newLastName }, Cmd.none)

-- View --

view : Model -> Html Action
view model =
  div []
    [ div []
        [ input [ onInput SetFirstName, value model.firstName ] []
        , input [ onInput SetLastName, value model.lastName ] []
        ]
    , (name model)
    ]

name : Model -> Html Action
name model =
  span [] [ text (model.firstName ++ " " ++ model.lastName) ]

-- Main --

main : Program Never Model Action
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }
