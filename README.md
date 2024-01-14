# Connect Four
An implementation of Connect Four written in Ruby using TDD principles. (The Odin Project)
  
## Usage

[![Run on Repl.it](https://replit.com/badge/github/AhmedTheGreatest/connect-four)](https://replit.com/new/github/AhmedTheGreatest/connect-four)

To play the game, run `$ ruby ./lib/main.rb` in your terminal
To run the tests, run `$ rspec` in your terminal

For info on how to play the game visit [Wikipedia](https://en.wikipedia.org/wiki/Connect_Four)

## Code Overview

The game contains the following classes:

- `Board`: Represents the 7x6 Connect Four board. Handles displaying, dropping discs, and game end checking.

- `Player`: Represents a player, with a name and disc symbol. Has a method to get input from player.

- `Game`: Manages the overall game flow, game loop, and logic. Handles switching players, displaying winner messages, etc.

- The `ConnectFour` module contains and ties together the other classes.
