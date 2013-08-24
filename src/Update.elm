module Update where

import open Model

-- Update the TodoState based on a user Action.
update : Action -> TodoState -> TodoState
update action state =
    case action of
      -- ignore if the user tries to add an empty task
      Add [] -> state

      -- add a task with a unique ID
      Add dsc -> { tasks = Task False dsc state.uid :: state.tasks
                 , uid   = state.uid + 1
                 }

      -- remove tasks with the given ID
      Remove n -> { state | tasks <- filter (\t -> t.id /= n) state.tasks }
