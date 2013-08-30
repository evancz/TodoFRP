-- Create the interactive UI elements needed for this program.
-- The state of these elements is needed by the display *and* to
-- update our model.
module Inputs (taskField, taskDelete, actions, fieldState) where

import Graphics.Input as Input
import Keyboard
import Model (Action, Add, Remove)

-- Signal that updates when the enter key is pressed. We will use
-- it to sample other signals. Actual value of this signal is not
-- important.
entered = keepIf id True Keyboard.enter

-- Create a dynamic field for task input
taskField = Input.simpleDynamicField ""

-- Current state of the input field:
--   Just use the current field state in most cases,
--   but if the user presses enter, clear the field.
fieldState : Signal String
fieldState = merge taskField.events (sampleOn entered (constant ""))

-- Keep track of buttons for deleting tasks.
taskDelete = Input.customButtons 0

-- Merge all UI inputs into Actions.
actions : Signal Action
actions = merge (Add <~ sampleOn entered taskField.events)
                (Remove <~ taskDelete.events)
