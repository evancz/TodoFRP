module Inputs (field, remove, actions, fieldContent) where
{-| Create the Signals and Inputs needed to model interaction in this program.
The Inputs we create will provide handles for our display to give us new
events, and from there, it will provide data to update our program.
-}

import Graphics.Input (Input, input)
import Graphics.Input.Field as Field
import Keyboard
import Model (Action, Add, Remove)

----  Inputs  ----

{-| An Input to keep track of the primary text field. -}
field : Input Field.Content
field = input Field.noContent

{-| An Input to keep track of requests to remove tasks. -}
remove : Input Int
remove = input 0


----  Useful Signals  ----

{-| Current content of the primary input field. Normally uses whatever the user
types in, but if the user presses enter it clears the field.
-}
fieldContent : Signal Field.Content
fieldContent =
    merge field.signal (always Field.noContent <~ entered)

{-| Merge all UI inputs into Actions. -}
actions : Signal Action
actions = merge (Add <~ sampleOn entered (.string <~ field.signal))
                (Remove <~ remove.signal)

{-| Signal that updates when the enter key is pressed. We will use it to sample
other signals. Actual value of this signal is not important.
-}
entered : Signal ()
entered = always () <~ keepIf id True Keyboard.enter
