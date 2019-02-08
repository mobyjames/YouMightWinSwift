# You Might Win
A pointless game


## Objectives

- Fix layout constraints in ContestViewController and ContestantView so that UI is symetrical with a  logical element hierarchy. See design comp / whiteboard.

- Improve state management in ContestViewController so that you cannot pick a winner before a round has started and starting a new round resets the winner.

- Improve the winner selection algorithm so that contestants' odds of winner are based on their number of points relative to each other.

- Finish the login screen:

  - After install, the app should start on this screen

  - Pressing "Login" should call the login API endpoint and continue to ContestViewController if successfull.

  - If there is an error, it should be displayed above the login button

  - Once a user has logged in, the app should skip this screen

-- BONUS

- Add animation - make winning event more exciting

- Make up a feature

- Fix a bug that wasn't pointed out

- Refactor code into services, models or other more maintainable scheme
