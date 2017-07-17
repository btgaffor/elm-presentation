import Html exposing (Html, Attribute, program, div, span, input, text, h1, code, pre, br, button)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- Model --

type alias UserData =
  {
    firstName: String,
    lastName: String
  }

type alias ContactData =
  {
    name: String,
    phone: String
  }

type Model = User UserData
           | Contact ContactData

model : Model
model =
  User
    {
      firstName = "Joe",
      lastName = "Schmoe"
    }

init: (Model, Cmd Action)
init = (model, Cmd.none)

-- Update --

type Action = SetFirstName UserData String
            | SetLastName UserData String
            | SetName ContactData String
            | SetPhone ContactData String
            | UseUser
            | UseContact

update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    SetFirstName user newFirstName -> (User { user | firstName = newFirstName }, Cmd.none)
    SetLastName user newLastName -> (User { user | lastName = newLastName }, Cmd.none)
    SetName contact newName -> (Contact { contact | name = newName }, Cmd.none)
    SetPhone contact newPhone -> (Contact { contact | phone = newPhone }, Cmd.none)
    UseUser -> (User { firstName = "Joe", lastName = "Schmoe" }, Cmd.none)
    UseContact -> (Contact { name = "Joe Schmoe", phone = "123-456-7890" }, Cmd.none)

-- View --

view : Model -> Html Action
view model =
  div []
    [ div [] (inputs model)
    , (name model)
    ]

inputs : Model -> List (Html Action)
inputs model =
  case model of
    User userData ->
      [ input [ onInput (SetFirstName userData), value userData.firstName ] []
      , input [ onInput (SetLastName userData), value userData.lastName ] []
      ]
    Contact contactData ->
      [ input [ onInput (SetName contactData), value contactData.name ] []
      , input [ onInput (SetPhone contactData), value contactData.phone ] []
      ]


name : Model -> Html Action
name model =
  case model of
    User { firstName, lastName } ->
      div []
        [ div [] [ text (firstName ++ " " ++ lastName) ]
        , button [ onClick UseContact ] [ text "Use Contact" ]
        ]
    Contact { name, phone } ->
      div []
        [ div [] [ text (name ++ " (" ++ phone ++ ")" )]
        , button [ onClick UseUser ] [ text "Use User" ]
        ]

-- Main --

main : Program Never Model Action
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }
