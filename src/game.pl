/*reconsult('m.pl').*/
/*first startGame, calls game main loop*/
startGame :- initial(GameState), gameLoop(GameState, 'B').

/*Main loop*/
gameLoop(GameState, Player) :- \+gameOver(GameState, Player),
                                display_game(GameState, Player),
                                move(GameState, Player, [X,Y]),
                                placePiece(GameState, Player, X, Y, NewGameState),
                                changePlayer(Player, NewPlayer),
                                gameLoop(NewGameState, NewPlayer).

/*If current player doesnt have any legal moves, switch to the next.*/
move(GameState, Player, [X, Y]) :- canMove(GameState, Player), getMove(GameState, Player, [X, Y]).

move(GameState, Player, [X, Y]) :- nl, write(Player), write(' has no possible moves!'), nl,
                                    changePlayer(Player, NewPlayer),
                                    getMove(GameState, NewPlayer, [X, Y]).



/*Receive input from player, and check if the move is legal.*/
getMove(GameState, Player, [X, Y]) :- write(Player), write(' to play.'), nl,
                            write('Where would you like to play?'), nl,
                            write('X: '),
                            read(X),
                            write('Y: '),
                            read(Y),
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


gameOver(GameState, Player) :- 2 == 3.

/*Checks if Player can make a move.*/

canMove([H|T], Player).

/*Checks if there is an opponent's piece adjacent to X, Y (must be true to play)*/
hasOpponentPieceAdjacent(GameState, Player, X, Y) :- changePlayer(Player, Opponent), 
                                ((getCell(X-1, Y-1, GameState, Value), (Value == Opponent));
                                (getCell(X-1, Y, GameState, Value),   (Value == Opponent));
                                (getCell(X-1, Y+1, GameState, Value), (Value == Opponent));
                                (getCell(X, Y-1, GameState, Value),   (Value == Opponent));
                                (getCell(X, Y+1, GameState, Value),   (Value == Opponent));
                                (getCell(X+1, Y-1, GameState, Value), (Value == Opponent));
                                (getCell(X+1, Y, GameState, Value),   (Value == Opponent));
                                (getCell(X+1, Y+1, GameState, Value), (Value == Opponent))).