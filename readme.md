Why use Elm?
============

-   No runtime errors, ever
-   No side effects, even accidentally
-   Complete type safety
-   Incredibly useful compilation error messages
-   DSL very similar to react + redux

Syntax
======

-   Records are almost like objects in javascript
    -   creating a new one: `model = { a = 1, b = 2 }`
    -   modifying a value: `{ model | a = 3 }`
-   concatenating strings: `"hello " ++ "world"`

-   Anonymous functions: `\x -> x * 2`

-   Functions calls don't need parentheses unless used as expressions
    ```Elm
    List.concat [[1, 2, 3], [4, 5, 6]]
    (List.filter (\x -> x > 6) (List.map (\x -> x * 2) (List.concat [[1, 2, 3], [4, 5, 6]])))
    ```

-   Pipe operator:
    ```Elm
    List.concat [[1, 2, 3], [4, 5, 6]] |> List.map (\x -> x * 2) |> List.filter (\x -> x > 6)
    ```

Notable Features
================

-   Every value must have a type
-   Pattern Matching
-   Every branch of a case statement must exist
-   Every function is curried

Error Handling
==============

-   No generic "null" / "undefined"
-   Errors are just data
-   Two main types: Maybe, Result
-   (demo)

Side Effects
============

-   No side effects are possible within the application
-   All data is immutable
-   Typical side effects like user input and getting random numbers are externalized to the Elm runtime via "commands"
-   (demo)

Tagged Data
===========

-   data can be "tagged" with a union type to indicate what it is
-   that union type can be switched on just like other types
-   once we've switched, that inner data can be used to type check it as a parameter to other functions
-   (demo)

Resources
=========

-   all of this code lives in <https://github.com/btgaffor/elm-presentation>
-   the master branch corresponds to *Syntax* and *Notable Features*
-   there are separate branches to demo *Error Handling*, *Side Effects*, and *Tagged Data*
