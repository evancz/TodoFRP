module Update where

import open Model

-- Update the TodoState based on a user Action.
update : Action -> TodoState -> TodoState
update action (tasks,uid) =
    case action of
      -- ignore if the user tries to add an empty task
      Add [] -> (tasks, uid)

      -- add a task with a unique ID
      Add dsc -> (Task False dsc uid :: tasks, uid + 1)

      -- remove tasks with the given ID
      Remove n -> (filter (\t -> t.id /= n) tasks, uid)
