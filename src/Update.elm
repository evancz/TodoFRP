module Update where

import open Model

-- Update the TodoState based on a user Action.
update : Action -> TodoState -> TodoState
update action state =
    case action of
      -- ignore if the user tries to add an empty task
      Add "" -> state

      -- add a task with a unique ID
      Add taskDescription ->
          { tasks = (Task False taskDescription state.uid) :: state.tasks
          , uid   = state.uid + 1 }

      -- keep tasks that do not have the removed ID
      Remove id ->
          { state |
              tasks <- filter (\task -> task.id /= id) state.tasks
          }
