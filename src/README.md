# FEUP-PLOG

## Mapello_4

Turma 1

Miguel Rodrigues Gomes up201605908

Pedro Miguel Afonso Teixeira  up201505916


## The game
Mapello is a board game based on Reversi designed by Simon M. Lucas. The objective is to have the highest ammount of pieces of the same colour (the one player chose) when there's no longer any valid move available. 

Full set of rules on https://nestorgames.com/#mapello_detail

## The pieces
 - White piece ('W')
 - Black piece ('B')
 - Walls: They act like normal walls (same as the outer part of the board) ('#')
 - Bonuses: They count as extra points when captured (+3 for each) ('P')
 - Jokers: They act as normal pieces of the player in turn ('J')


## Setup
The players can choose between playing an original board setup or create their own by choosing where the walls, bonuses and jokers go.

Note that only jokers can be put in the outer part of the board.

## Playing phase
The players alternate turns having to place a piece adjacent to an opponent's piece (vertically, horizontally or diagonally). The player then captures all pieces contigous in a straight line between the newly placed piece and a player's piece or joker turning them into their own pieces. If a player is unable to capture a piece in his move he passes.

At the end the player with the most points wins.

## Representation of the gamestate

![All boardsd](https://github.com/omiguelgomes/FEUP-PLOG/blob/master/TI/allboardsinone.png?raw=true)
         
         

## Gamestate display

![Code to print board](https://raw.githubusercontent.com/omiguelgomes/FEUP-PLOG/master/TI/printingtheboard.PNG)




## Game Logic

The board is represented as a list of lists. Each list representing a row, and containing 10 elements, one for each cell.

# ADICIONAR IMAGEM

The pieces are represented as characters, and can be one of the following:
 - White piece ('W')
 - Black piece ('B')
 - Walls: They act like normal walls (same as the outer part of the board) ('#')
 - Bonuses: They count as extra points when captured (+3 for each) ('P')
 - Jokers: They act as normal pieces of the player in turn ('J')

 The current player is stored as a character, and can either be 'B' for black, and 'W' for white.

 The game starts with the execution of the play/0 predicate, which prints a menu screen to the console, and asks for user input to choose the game mode.

``` prolog
play :- printMainMenu, 
       write('What mode would you like to play?'),
       read(Input),
       manageInput(Input).


manageInput(1) :-  startGame.
manageInput(2) :-  startGamePvsC.
manageInput(3) :-  StartGameCvsC.
manageInput(Else) :- write('Invalid mode!').

```

Which will output the following

![Menu output](https://imgur.com/GPqz2ow.png)

If the player selects the first mode, startGame will be called, which will call the gameLoop.

``` prolog
startGame :- initial(GameState), gameLoop(GameState, 'B').

gameLoop(GameState, Player) :- \+game_over(GameState, Player),
                                printScore(GameState), 
                                display_game(GameState, Player),
                                move(GameState, Player, [X,Y]),
                                placePiece(GameState, Player, X, Y, NewGameState),
                                getOpponent(Player, Opponent),
                                gameLoop(NewGameState, Opponent).
```

In this loop, first we check if the game is over, which would happen if both players have no available moves

``` prolog
game_over(GameState, Player) :- \+canMove(GameState, Player), getOpponent(Player, Opponent), \+canMove(GameState, Opponent).

``` 
Then, we display the current board, and the current score, with the following code:

``` prolog
display_game(GameState, Player) :- printCoordsBar, printBoard(GameState, 0).

printCoordsBar :- nl, write('      A   B   C   D   E   F   G   H   I   J  '), nl,
                      write('    -----------------------------------------'), nl.

printBoard([H|T], RowNr) :- write('  '), write(RowNr), write(' '),
                            NextRowNr is RowNr + 1,
                            printRow(H),
                            nl,
                            write('    -----------------------------------------'), nl,
                            printBoard(T, NextRowNr).

printBoard([], _).


printRow([H|T]) :- write('| '), write(H), write(' '), printRow(T). 
printRow([]) :- write('|').

printScore(GameState) :- getScore(GameState, SP1, SP2),
                         write('SCORE: '), 
                         write('  White: '), write(SP2),
                         write('  Black: '), write(SP1), nl.

```
Afterwards, we call the move/3 predicate, which asks for the user's input, parses it, and checks if it is a valid move. If it isn't, an error message is displayed, and the input is asked for again.

``` prolog
move(GameState, Player, [X, Y]) :- canMove(GameState, Player), getMove(GameState, Player, [X, Y]).

move(GameState, Player, [X, Y]) :- nl, write(Player), write(' has no possible moves!'), nl,
                                    getOpponent(Player, Opponent),
                                    getMove(GameState, Opponent, [X, Y]).



getMove(GameState, Player, [X, Y]) :- write(Player), write(' to play.'), nl,
                            write('Where would you like to play?'), nl,
                            write('X: '), read(Temp),
                            write('Y: '), read(Y),
                            convertX(Temp, X), 
                            validateMove(GameState, Player, X, Y).

getMove(GameState, Player, [X, Y]) :- write('Invalid position, choose another one.'), nl, getMove(GameState, Player, [X, Y]).

```