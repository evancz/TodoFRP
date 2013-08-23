module Display (display, input, taskField) where

import Graphics.Input as Input
import Keyboard
import open Model

-- Create the task field. It gets cleared whenever the user presses enter.
taskInput = Input.fields Input.emptyFieldState
entered = keepIf id True Keyboard.enter

taskFieldState =
    let resetOnEnter = sampleOn entered (constant Input.emptyFieldState)
    in  merge taskInput.events resetOnEnter

taskField = taskInput.field id "What needs to be done?" <~ taskFieldState

-- Keep track of buttons for deleting tasks.
taskDelete = Input.customButtons 0

-- Merge all UI inputs into the input signal.
input : Signal Action
input = merges [ Remove <~ taskDelete.events,
                 (\field -> Add field.string) <~ sampleOn entered taskInput.events ]


-- Actually display the entire Todo list.
display : (Int,Int) -> Element -> [Task] -> Element
display (w,h) taskField tasks =
  let pos = midTopAt (relative 0.5) (absolute 40)
  in  layers
        [ tiledImage w h "/texture.png"
        , [markdown|<style>input:focus { outline: none; }</style>|]
        , container w h pos <|
          flow down
          [ toText "todos" |> Text.height 48
                           |> Text.color (rgb 179 179 179)
                           |> centered
                           |> width 500
          , spacer 500 15 |> color (rgb 141 125 119)
          , spacer 500 1  |> color (rgb 108 125 119)
          , color (rgb 247 247 247) . container 500 45 midRight <|
                  (taskField |> width 440 |> height 45)
          , flow down <| map displayTask tasks ]
        ]

btn : String -> Element
btn str = container 30 30 middle . text . Text.height 28 . bold <| toText str

grey : Color
grey = rgb 200 200 200

displayTask : Task -> Element
displayTask task =
    color (rgba 255 255 255 0.9) . container 500 30 midRight <|
    flow right [ container 410 30 midLeft . text <| toText task.description
               , taskDelete.customButton task.id
                   (btn "") (btn "&times;") (btn "&times;") ]
