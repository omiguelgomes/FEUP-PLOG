/*reconsult('m.pl').*/
/*first startGame, calls game main loop*/
startGame :- initial(GameState), gameLoop(GameState, 'B').

/*Main loop*/
gameLoop(GameState, Player) :- \+gameOver(GameState, Player),
                                printScore(GameState), 
                                display_game(GameState, Player),
                                move(GameState, Player, [X,Y]),
                                placePiece(GameState, Player, X, Y, NewGameState),
                                getOpponent(Player, Opponent),
                                gameLoop(NewGameState, Opponent).

/*If current player doesnt have any legal moves, switch to the next.*/
move(GameState, Player, [X, Y]) :- canMove(GameState, Player), getMove(GameState, Player, [X, Y]).

move(GameState, Player, [X, Y]) :- nl, write(Player), write(' has no possible moves!'), nl,
                                    getOpponent(Player, Opponent),
                                    getMove(GameState, Opponent, [X, Y]).



/*Receive input from player, and check if the move is legal.*/
getMove(GameState, Player, [X, Y]) :- write(Player), write(' to play.'), nl,
                            write('Where would you like to play?'), nl,
                            write('X: '), read(TempX),
                            write('Y: '), read(Y),
                            convertX(TempX, X),
                            validateMove(GameState, Player, X, Y).

getMove(GameState, Player, [X, Y]) :- write('Invalid position, choose another one.'), nl, getMove(GameState, Player, [X, Y]).



/*Flip all pieces after the players move*/


/*Check if move is legal.*/
validateMove(GameState, Player, X, Y) :- X < 10, X > 0, Y < 10, Y > 0,
                                getCell(X, Y, GameState, Value), Value == ' ',
                                hasOpponentPieceAdjacent(GameState, Player, X, Y).

/*Places piece in position X, Y*/
placePiece([H|T], Player, X, 0, [H2|T]) :- placePiece(H, Player, X, -1, H2).
placePiece([H|T], Player, X, Y, [H|R]) :- Y > -1, Y1 is Y-1, placePiece(T, Player, X, Y1, R). 

placePiece([_|T], Player, 0, -1, [Player|T]).
placePiece([H|T], Player, X, -1, [H|R]) :- X > -1, X1 is X-1, placePiece(T, Player, X1, -1, R).


/*Checks if game is over*/
gameOver(GameState, Player) :- \+canMove(GameState, Player), getOpponent(Player, Opponent), \+canMove(GameState, Opponent).

/*Checks if Player can make a move. Player can make a move if there is a square X, Y where
an opponent's piece is adjacent(use function below), and must turn at least one of the opponent's piece*/
canMove([H|T], Player).

/*Checks if there is an opponent's piece adjacent to X, Y (must be true to play)*/
hasOpponentPieceAdjacent(GameState, Player, X, Y) :- getOpponent(Player, Opponent), (
                                                     getCell(X-1, Y-1, GameState, Opponent);
                                                     getCell(X-1, Y,   GameState, Opponent);
                                                     getCell(X-1, Y+1, GameState, Opponent);
                                                     getCell(X, Y-1,   GameState, Opponent);
                                                     getCell(X, Y+1,   GameState, Opponent);
                                                     getCell(X+1, Y-1, GameState, Opponent);
                                                     getCell(X+1, Y,   GameState, Opponent);
                                                     getCell(X+1, Y+1, GameState, Opponent)).

/*Get current score on the table, player1 is black, player2 is white*/

getScore(GameState, ScorePlayer1, ScorePlayer2) :- getPlayerScore('B', GameState, ScorePlayer1),
                                                    getPlayerScore('W', GameState, ScorePlayer2).

getPlayerScore(Player, GameState, Score) :- append(GameState, Flattened), getScoreInRow(Player, Flattened, Score).
                                          
getScoreInRow(_, [], 0).
getScoreInRow(Player, [Player|T], Score) :- !, getScoreInRow(Player, T, ScoreTemp), Score is ScoreTemp + 1.
getScoreInRow(Player, [_Player|T], Score) :- getScoreInRow(Player, T, Score).

/*getScoreInRow('B', ['a', 'B', 'W', 'B', 'a', 'B', 'a'], Score).*/

/*getScore([['B', 'W'], ['W', 'W']], Score1, Score2)*/
