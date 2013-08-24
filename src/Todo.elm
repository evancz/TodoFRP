module Todo where

import Window
import Model (initialState, TodoState)
import Update (update)
import Display (display, fieldState, input)


-- Use the UI inputs to update starting from the initial state.
currentState : Signal TodoState
currentState = foldp update initialState input

--Show everything on screen.
main : Signal Element
main = display <~ Window.dimensions
                ~ fieldState
                ~ lift .tasks currentState
