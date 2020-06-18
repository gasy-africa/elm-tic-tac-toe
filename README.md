# Elm Tic-Tac-Toe
A simple Elm tic-tac-toe game (no minmax algo).

To run the application simply pull down the repo locally and open up dist/index.html in your browser.


See <https://github.com/elm/compiler/blob/master/upgrade-docs/0.19.md>
and the documentation for your dependencies for more information.

Here are some common upgrade steps that you will need to do manually:

- elm/core
  - [ ] Replace uses of toString with String.fromInt, String.fromFloat, or Debug.toString as appropriate
- elm/html
  - [ ] If you used Html.program*, install elm/browser and switch to Browser.element or Browser.document
  - [ ] If you used Html.beginnerProgram, install elm/browser and switch Browser.sandbox


elm install elm/random 
elm install elm-community/list-extra
