module Model where

-- All of the information needed to represent a Task
type Task = { done:Bool, description:String, id:Int }

-- The state of the application is a list of tasks and an
-- ID for naming tasks uniquely.
type TodoState = { tasks:[Task], uid:Int }

initialState : TodoState
initialState = { tasks=[], uid=0 }

-- Actions the user can take to modify the TodoState
data Action = Add String | Remove Int
