# TodoFRP

This is a basic todo list, written with FRP in Elm.

It demonstrates how FRP and Elm can be used for more traditional web apps.

### Project Layout

All of the code for this project lives in the `src/` directory.

* [Model.elm](https://github.com/evancz/TodoFRP/blob/master/src/Model.elm):
  Representation of the todo list application.
* [Update.elm](https://github.com/evancz/TodoFRP/blob/master/src/Update.elm):
  Describes how to update the todo list based on user's actions.
* [Display.elm](https://github.com/evancz/TodoFRP/blob/master/src/Display.elm):
  How to display our model on screen. Describes interactive UI elements.
* [Todo.elm](https://github.com/evancz/TodoFRP/blob/master/src/Todo.elm):
  Bring together the model, update, and display to create the todo list.

