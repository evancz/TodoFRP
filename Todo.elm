module Todo where

import Window

import Model
import Update
import Display

tasks = fst <~ foldp Update.update Model.initialState Display.input

main = Display.display <~ Window.dimensions ~ Display.taskField ~ tasks
