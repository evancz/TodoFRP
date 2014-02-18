module Display (display) where

import Model (Task)
import Inputs (field, remove)
import Graphics.Input as Input

-- Constants for easy tweaking
todoWidth   = 500
leftPadding = 60
buttonWidth = 30
taskHeight  = 30

titleColor   = rgb 179 179 179
spacerColor1 = rgb 141 125 119
spacerColor2 = rgb 108 125 119
inputColor   = rgb 247 247 247
taskColor    = rgba 255 255 255 0.9


-- Actually display the entire Todo list.
display : (Int,Int) -> Input.FieldContent -> [Task] -> Element
display (w,h) fieldContent tasks =
    let pos = midTopAt (relative 0.5) (absolute 40) in
    layers [ tiledImage w h "/texture.png"
           , container w h pos <| flow down [ header
                                            , inputBar fieldContent
                                            , flow down (map displayTask tasks) ]
           ]

header : Element
header = 
    flow down
      [ width todoWidth . centered . Text.color titleColor . Text.height 48 <| toText "todos"
      , color spacerColor1 (spacer todoWidth 15)
      , color spacerColor2 (spacer todoWidth 1 ) ]

inputBar : Input.FieldContent -> Element
inputBar fieldContent =
    color inputColor . container todoWidth 45 midRight .
    color inputColor . size (todoWidth - leftPadding) 45 <|
        Input.field field.handle id "What needs to be done?" fieldContent

-- Display a specific task.
displayTask : Task -> Element
displayTask task =
    let btn clr =
            let x = text . Text.height (taskHeight-4) . Text.color clr <| toText "X"
            in  container buttonWidth taskHeight middle x
        taskWidth = todoWidth - leftPadding - buttonWidth
    in
       color taskColor . container todoWidth taskHeight midRight <|
       flow right [ container taskWidth taskHeight midLeft . text <| toText task.description
                  , Input.customButton remove.handle task.id
                        (btn inputColor) (btn titleColor) (btn red)
                  ]
