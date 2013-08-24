module Todo where

import Window
import Model (initialState)
import Update (update)
import Display (display, taskFeild, input)


-- Use the UI inputs to update starting from the initial state.
tasks : Signal [Task]
tasks = fst <~ foldp update initialState input

--Show everything on screen.
main : Signal Element
main = display <~ Window.dimensions ~ taskField ~ tasks
