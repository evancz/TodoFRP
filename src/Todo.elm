module Todo where

import Window
import Model (initialState, TodoState)
import Update (update)
import Display (display)
import Inputs (fieldContent, actions)


-- Use the UI inputs to update starting from the initial state.
currentState : Signal TodoState
currentState = foldp update initialState actions

-- Show everything on screen.
main : Signal Element
main = display <~ Window.dimensions
                ~ fieldContent
                ~ lift .tasks currentState
