module Todo where

import Window

import Model
import Update
import Display

descriptions = lift fst <| foldp Update.update Model.initialState Display.input

main = Display.display <~ Window.dimensions ~ Display.taskField ~ descriptions
