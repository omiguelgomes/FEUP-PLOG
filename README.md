# FEUP-PLOG

## Mapello_4

Turma 1

Miguel Rodrigues Gomes up201605908

Pedro Miguel Afonso Teixeira  up201505916


## The game
Mapello is a board game based on Reversi designed by Simon M. Lucas. The objective is to have the highest ammount of pieces of the same colour (the one player chose) when there's no longer any valid move available. 

Full set of rules on https://nestorgames.com/#mapello_detail

## Game Logic
The board is represented as a list of lists. Each list representing a row, and containing 10 elements, one for each cell.

``` prolog
initial([['#', '#', '#', 'J', '#', '#', 'J', '#', '#', '#'], 
         ['#', '#', ' ', 'P', ' ', 'P', ' ', ' ', '#', '#'], 
         ['#', ' ', ' ', ' ', ' ', ' ', '#', ' ', 'P', 'J'], 
         ['#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#'], 
         ['#', 'P', '#', ' ', 'W', 'B', ' ', ' ', ' ', '#'], 
         ['J', ' ', ' ', ' ', 'B', 'W', ' ', ' ', ' ', '#'], 
         ['#', 'P', ' ', ' ', ' ', ' ', ' ', '#', 'P', 'J'], 
         ['#', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#'], 
         ['#', '#', ' ', 'P', ' ', ' ', ' ', 'P', '#', '#'], 
         ['#', '#', '#', 'J', 'J', '#', '#', 'J', '#', '#']]).
```

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

If the player selects the first mode, startGame will be called, which will call the gameLoop. The gameLoop will execute each of the predicates described below, and then call itself recursively. Only if the game is over will the loop end.

``` prolog
gameLoop(GameState, Player) :- \+game_over(GameState, Player, Winner),
                                getMove(GameState, Player, [X,Y]),
                                move(GameState, Player, [X,Y], NewGameState),
                                getOpponent(Player, Opponent),
                                display_game(NewGameState, Opponent),
                                gameLoop(NewGameState, Opponent).
```

In this loop, first we check if the game is over, which would happen if both players have no available moves. If either of the canMove/2 predicate fails, game_over will succeed, ending the game. We included a cut, so that in case the game_over fails (which will happen most of the time), it will not try to backtrack and find a solution.

``` prolog
game_over(GameState, Player, Winner) :- !, \+canMove(GameState, Player), 
                                        getOpponent(Player, Opponent), 
                                        \+canMove(GameState, Opponent), 
                                        endGame(GameState, Winner).
``` 
Then, we display the current board, and the current score. The display_game is very simple, it prints a top bar for the coordinates of the cells, and then prints each row of the board at a time, recursively. The display_game predicate also calls printScore, which is a wrapper function to call getScore (which is itself a wrapper function that calls value/3 for both players), which will be explained afterwards.

``` prolog
display_game(GameState, Player) :- printScore(GameState), 
                                   printCoordsBar, 
                                   printBoard(GameState, 0).

printCoordsBar :- nl, write('      A   B   C   D   E   F   G   H   I   J  \n'),
                      write('    -----------------------------------------\n').


printBoard([H|T], RowNr) :- format('  ~d ', [RowNr]),
                            NextRowNr is RowNr + 1,
                            printRow(H),
                            nl,
                            write('    -----------------------------------------\n'),
                            printBoard(T, NextRowNr).

printBoard([], _).


printRow([H|T]) :- format('| ~s ', [H]), printRow(T). 
printRow([]) :- write('|').

printScore(GameState) :- getScore(GameState, SP1, SP2),
                         write('\nSCORE: '), 
                         format('  White: ~d', [SP2]),
                         format('  Black: ~d\n', [SP1]).

```
Afterwards, we call the move/3 predicate, which asks for the user's input, parses it, and checks if it is a valid move. If it isn't, an error message is displayed, and the input is asked for again. First, it checks if the player canMove, which is simply verifying if there is at least one cell where the player can place a piece. To do this, we find all the valid moves for Player, and check that the list isn't empty. Afterwards, we use placePiece which will call itself recursively untill it finds the X, Y position, and places a player's piece there, storing the new GameState in the last argument.

``` prolog
move(GameState, Player, [X, Y], GameStateAfterMove) :- canMove(GameState, Player),
                                                       placePiece(GameState, Player, X, Y, NewGameState),
                                                       flipPieces(NewGameState, Player, X, Y, _, GameStateAfterMove).

move(GameState, Player, [X, Y]) :- format('\n ~s has no possible moves!\n', [Player]),
                                   getOpponent(Player, Opponent),
                                   getMove(GameState, Opponent, [X, Y]).


getMove(GameState, Player, [X, Y]) :- format('~s to play.', [Player]), nl,
                                      write('Where would you like to play?'), nl,
                                      write('X: '), read(Temp),
                                      write('Y: '), read(Y),
                                      convertX(Temp, X), 
                                      validateMove(GameState, Player, X, Y).

getMove(GameState, Player, [X, Y]) :- write('Invalid position, choose another one.'), nl, 
                                      getMove(GameState, Player, [X, Y]).

canMove(GameState, Player) :- valid_moves(GameState, Player, ListofMoves), \+length(ListofMoves, 0).

placePiece([H|T], Player, X, 0, [H2|T]) :- placePiece(H, Player, X, -1, H2).
placePiece([H|T], Player, X, Y, [H|R]) :- Y > -1, Y1 is Y-1, placePiece(T, Player, X, Y1, R). 

placePiece([_|T], Player, 0, -1, [Player|T]).
placePiece([H|T], Player, X, -1, [H|R]) :- X > -1, X1 is X-1, placePiece(T, Player, X1, -1, R).
```

To verify if the move is valid, we use the validateMove/4 predicate which checks if the X and Y values are within the board limits, the cell is either empty or a bonus, the cell is adjacent to an opponent's and that the move will flip at least one of the opponent's pieces.

``` prolog
validateMove(GameState, Player, X, Y) :- X < 10, X > 0, Y < 10, Y > 0,
                                         getCell(X, Y, GameState, Value), (Value == ' ' ; Value == 'P'),
                                         hasOpponentPieceAdjacent(GameState, Player, X, Y),
                                         flipPieces(GameState, Player, X, Y, _, GameStateAfterMove),
                                         GameState \== GameStateAfterMove.
```

After the move was made, we change the current player to the opponent, and display the game again, which will output the following:

![Game output](https://imgur.com/CM29AK2.png)

As we can see, the score is shown every time the board is printed out. In order to determine the current score for each player, we use the value/3 predicate.

``` prolog
value(GameState, Player, Score) :- append(GameState, Flattened), 
                                   getScoreInRow(Player, Flattened, PiecesScore), 
                                   getBonus(GameState, Player, BonusScore),
                                   Score is PiecesScore+BonusScore.
                                          
getScoreInRow(_, [], 0).
getScoreInRow(Player, [Player|T], Score) :- !, getScoreInRow(Player, T, ScoreTemp), 
                                            Score is ScoreTemp + 1.
getScoreInRow(Player, [_|T], Score) :- getScoreInRow(Player, T, Score).

getBonus(GameState, Player, BonusScore) :- bonus(BonusList), getBonus(GameState, Player, BonusList, BonusScore, 0).

getBonus(GameState, Player, [X-Y|T], BonusScore, Temp) :- getCell(X, Y, GameState, Player), 
                                                          NewTemp is Temp + 3,
                                                          getBonus(GameState, Player, T, BonusScore, NewTemp).

getBonus(GameState, Player, [X-Y|T], BonusScore, Temp) :- getCell(X, Y, GameState, _),     
                                                          getBonus(GameState, Player, T, BonusScore, Temp).
getBonus(_, _, [], Bonus, Bonus).
```

Apart from the PlayervsPlayer mode, we have implemented a PlayervsComputer and a ComputervsComputer mode. In order to obtain a move for the Computer, we have implemented the choose_move/4 predicate. Our ai has 5 different levels of difficulty (1-5). The level 5 ai is the best player, and will always play the best move possble. The level 4 ai is the second best, and will always play the second best move possible, and so on untill level 1.
The choose_move predicate will start by finding the best possible move for the given Player, in the current GameState (board). If the ai level is 5, it stores the chosen move to be returned, if it is of a lower level, it will delete the best move from the list of possible moves, and find the best move in the new list, guaranteeing that the move chosen by a lower level ai is always worse. This last process will repeat itself Level-4 number of times.

``` prolog
choose_move(GameState, Player, Level, X-Y) :- valid_moves(GameState, Player, ListOfMoves), 
                                              length(ListOfMoves, ListLength), 
                                              choose_move(GameState, Player, Level, ListOfMoves,  X-Y).

choose_move(_, _, _, [X-Y], X-Y).

choose_move(GameState, Player, 5, ListOfMoves, X-Y) :- getBestMove(GameState, Player, ListOfMoves, X-Y, [], 0).

choose_move(GameState, Player, Level, ListOfMoves, X-Y) :- getBestMove(GameState, Player, ListOfMoves, X1-Y1, [], 0),
                                                           delete(ListOfMoves, X1-Y1, NewListOfMoves),
                                                           Level1 is Level+1,
                                                           choose_move(GameState, Player, Level1, NewListOfMoves, X-Y).
                                                                      

getBestMove(GameState, Player, [X-Y|T], BestMove, _, BestMoveValue) :-   move(GameState, Player, [X, Y], NewGameState),
                                                                         value(NewGameState, Player, Score),
                                                                         Score >= BestMoveValue, 
                                                                         getBestMove(GameState, Player, T, BestMove, X-Y, Score).

getBestMove(GameState, Player, [_|T], BestMove, BestMoveTemp, BestMoveValue) :- getBestMove(GameState, Player, T, BestMove, BestMoveTemp, BestMoveValue).

getBestMove(_, _, [], BestMove, BestMove, _).
```


## Conclusions

## References
During the development of this project, we based our research on the SICSTUS official documentation: https://sicstus.sics.se/sicstus/docs/3.7.1/html/sicstus_toc.html
