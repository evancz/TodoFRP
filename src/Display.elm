module Display (display, input, fieldState) where

import Graphics.Input as Input
import Keyboard
import open Model

-- Actually display the entire Todo list.
display : (Int,Int) -> Input.FieldState -> [Task] -> Element
display (w,h) fieldState tasks =
  let pos = midTopAt (relative 0.5) (absolute 40)
      grey = rgb 247 247 247
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
          , color grey . container 500 45 midRight . color grey . width 440 . height 45 <|
                  taskField.field id "What needs to be done?" fieldState
          , flow down <| map displayTask tasks ]
        ]

-- Display a specific task.
displayTask : Task -> Element
displayTask task =
    let btn : (Text -> Text) -> Element
        btn f = container 30 30 middle . text . Text.height 28 . f <| toText "&times;"
        grey = rgb 230 230 230
    in 
        color (rgba 255 255 255 0.9) . container 500 30 midRight <|
        flow right [ container 410 30 midLeft . text <| toText task.description
                   , taskDelete.customButton task.id
                         (btn <| Text.color grey) (btn id) (btn bold)
                   ]


-- Now we create the interactive UI elements needed for this program.
-- The state of these elements is needed by the display *and* to
-- update our model.

-- Create a dynamic text field and keep track of when the user presses enter.
taskField = Input.fields Input.emptyFieldState
entered = keepIf id True Keyboard.enter

-- This is what the user has typed in.
-- It gets cleared when the user presses Enter.
fieldState : Signal Input.FieldState
fieldState =
    let resetOnEnter = sampleOn entered (constant Input.emptyFieldState)
    in  merge taskField.events resetOnEnter

-- Keep track of buttons for deleting tasks.
taskDelete = Input.customButtons 0

-- Merge all UI inputs into the input signal.
input : Signal Action
input = merges [ Remove <~ taskDelete.events,
                 (\field -> Add field.string) <~ sampleOn entered taskField.events ]

