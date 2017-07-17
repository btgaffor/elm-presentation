import Html exposing (Html, Attribute, program, div, span, input, text, h1, code, pre, br, button)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random
import Array exposing (Array)

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
            | RequestRandomize
            | PerformRandomize Int

update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    SetFirstName newFirstName -> ({ model | firstName = newFirstName }, Cmd.none)
    SetLastName newLastName -> ({ model | lastName = newLastName }, Cmd.none)
    RequestRandomize -> (model, Random.generate PerformRandomize (Random.int Random.minInt Random.maxInt))
    PerformRandomize seed -> ((randomizeNames model seed), Cmd.none)

randomizeNames : Model -> Int -> Model
randomizeNames model seedRandomizer =
  let
    initialSeed = Random.initialSeed seedRandomizer
    (newFirstName, firstNameSeed) = getFirstName initialSeed
    (newLastName, lastNameSeed) = getLastName firstNameSeed
  in
    { model | firstName = newFirstName, lastName = newLastName }

getFirstName : Random.Seed -> (String, Random.Seed)
getFirstName initialSeed =
  let
    (index, newSeed) = Random.step (Random.int 0 3) initialSeed
  in
    case (Array.fromList ["James", "Mary", "John", "Elizabeth"] |> Array.get index) of
      Just name -> (name, newSeed)
      Nothing -> ("Joe", newSeed)

getLastName : Random.Seed -> (String, Random.Seed)
getLastName initialSeed =
  let
    (index, newSeed) = Random.step (Random.int 0 3) initialSeed
  in
    case (Array.fromList ["Smith", "Johnson", "Williams", "Jones"] |> Array.get index) of
      Just name -> (name, newSeed)
      Nothing -> ("Smith", newSeed)

-- View --

view : Model -> Html Action
view model =
  div []
    [ div []
        [ input [ onInput SetFirstName, value model.firstName ] []
        , input [ onInput SetLastName, value model.lastName ] []
        ]
    , (name model)
    , button [ onClick RequestRandomize ] [ text "Randomize!" ]
    ]

name : Model -> Html Action
name model =
  div [] [ text (model.firstName ++ " " ++ model.lastName) ]

-- Main --

main : Program Never Model Action
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }
