:- use_module(library(system)).
/*first startGame, calls game main loop*/
startGame :- initial(GameState), gameLoop(GameState, 'B').
startGamePvsC(Level) :- initial(GameState), gameLoopPvsC(GameState, 'B', Level).
startGameCvsC(LevelBlack, LevelWhite) :- initial(GameState), gameLoopCvsC(GameState, LevelBlack, LevelWhite, 'B').


/*PvP Main loop*/
gameLoop(GameState, Player) :- \+game_over(GameState, Player),
                                display_game(GameState, Player),
                                move(GameState, Player, [X,Y]),
                                placePiece(GameState, Player, X, Y, NewGameState),
                                getOpponent(Player, Opponent),
                                gameLoop(NewGameState, Opponent).

gameLoop(_, _).

/*PvC Main loop*/
gameLoopPvsC(GameState, Player, Level) :- \+game_over(GameState, Player),
                                          display_game(GameState, Player),
                                          move(GameState, Player, [X,Y]),
                                          placePiece(GameState, Player, X, Y, NewGameState),
                                          \+game_over(GameState, Opponent),
                                          getOpponent(Player, Opponent),
                                          choose_move(NewGameState, Opponent, Level, X1-Y1),
                                          convertX(X1Converted, X1),
                                          format('I\'m going to play ~s, ~d', [X1Converted, Y1]),
                                          sleep(2),
                                          placePiece(NewGameState, Opponent, X1, Y1, NewNewGameState),
                                          gameLoopPvsC(NewNewGameState, Player, Level).

gameLoopPvsC(_, _).

/*CvC Main loop*/
gameLoopCvsC(GameState, LevelBlack, LevelWhite, 'B') :- !, \+game_over(GameState, 'B'),
                                                           display_game(GameState, 'B'),
                                                           choose_move(GameState, 'B', LevelBlack, X1-Y1),
                                                           convertX(X1Converted, X1),
                                                           format('Black is going to play ~s, ~d\n', [X1Converted, Y1]),
                                                           sleep(2),
                                                           placePiece(GameState, 'B', X1, Y1, NewGameState),
                                                           gameLoopCvsC(NewGameState, LevelBlack, LevelWhite, 'W').

gameLoopCvsC(GameState, LevelBlack, LevelWhite, 'W') :- !, \+game_over(GameState, 'W'),
                                                           display_game(GameState, 'W'),
                                                           choose_move(GameState, 'W', LevelWhite, X1-Y1),
                                                           convertX(X1Converted, X1),
                                                           format('White is going to play ~s, ~d\n', [X1Converted, Y1]),
                                                           sleep(2),
                                                           placePiece(GameState, 'W', X1, Y1, NewGameState),
                                                           gameLoopCvsC(NewGameState, LevelBlack, LevelWhite, 'B').

gameLoopCvsC(_, _, _).                                                    

/*If current player doesnt have any legal moves, switch to the next.*/
move(GameState, Player, [X, Y]) :- canMove(GameState, Player), getMove(GameState, Player, [X, Y]).

move(GameState, Player, [X, Y]) :- format('\n ~s has no possible moves!\n', [Player]),
                                   getOpponent(Player, Opponent),
                                   getMove(GameState, Opponent, [X, Y]).


/*Receive input from player, and check if the move is legal.*/
getMove(GameState, Player, [X, Y]) :- format('~s to play.', [Player]), nl,
                            write('Where would you like to play?'), nl,
                            write('X: '), read(Temp),
                            write('Y: '), read(Y),
                            convertX(Temp, X), 
                            validateMove(GameState, Player, X, Y).

getMove(GameState, Player, [X, Y]) :- write('Invalid position, choose another one.'), nl, getMove(GameState, Player, [X, Y]).



/*Flip all pieces after the players move*/
flipPieces(GameState, Player, X, Y).


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
/*TODO: RETURN WINER*/
game_over(GameState, Player) :- !, \+canMove(GameState, Player), getOpponent(Player, Opponent), \+canMove(GameState, Opponent), endGame(GameState).

/*Checks if Player can make a move. Player can make a move if there is a square X, Y where
an opponent's piece is adjacent(use function below), and must turn at least one of the opponent's piece*/
canMove(GameState, Player) :- valid_moves(GameState, Player, ListofMoves), \+length(ListofMoves, 0).

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

getScore(GameState, ScorePlayer1, ScorePlayer2) :- value( GameState, 'B', ScorePlayer1),
                                                    value( GameState, 'W', ScorePlayer2).

value(GameState, Player, Score) :- append(GameState, Flattened), getScoreInRow(Player, Flattened, Score).
                                          
getScoreInRow(_, [], 0).
getScoreInRow(Player, [Player|T], Score) :- !, getScoreInRow(Player, T, ScoreTemp), Score is ScoreTemp + 1.
getScoreInRow(Player, [_Player|T], Score) :- getScoreInRow(Player, T, Score).

/*Returns list of possible moves for Player*/
valid_moves(GameState, Player, ListofMoves) :- valid_moves(GameState, Player, ListofMoves, [], 1, 1).

valid_moves(_, _, ListofMoves, ListofMoves, 0, 0).

valid_moves(GameState, Player, ListofMoves, TempMoves, X, Y) :- (X \= 0 ; Y \= 0),
                                                                validateMove(GameState, Player, X, Y),
                                                                append(TempMoves, [X-Y], NewTempMoves),
                                                                nextCell(X, Y, NewX, NewY), !,
                                                                valid_moves(GameState, Player, ListofMoves, NewTempMoves, NewX, NewY).

valid_moves(GameState, Player, ListofMoves, TempMoves, X, Y) :- (X \= 0 ; Y \= 0),
                                                                \+validateMove(GameState, Player, X, Y), 
                                                                nextCell(X, Y, NewX, NewY), !,
                                                                valid_moves(GameState, Player, ListofMoves, TempMoves, NewX, NewY).

endGame(GameState) :- getScore(GameState, ScorePlayer1, ScorePlayer2), ScorePlayer1 < ScorePlayer2,
                      format('Game Over\nFinal score:  White: ~d  Black: ~d\n', [ScorePlayer2, ScorePlayer1]),
                      write('White won!\n').

endGame(GameState) :- getScore(GameState, ScorePlayer1, ScorePlayer2), ScorePlayer1 > ScorePlayer2,
                      format('Game Over\nFinal score:  White: ~d  Black: ~d\n', [ScorePlayer2, ScorePlayer1]),
                      write('Black won!\n').

endGame(GameState) :- getScore(GameState, ScorePlayer1, ScorePlayer2), ScorePlayer1 =:= ScorePlayer2,
                      format('Game Over\nFinal score:  White: ~d  Black: ~d\n', [ScorePlayer2, ScorePlayer1]),
                      write('Game ended in a tie!\n').