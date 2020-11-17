%first startGame, shows original board, and calls real startGame
startGame :- initial(GameState), gameLoop(GameState, 'B').

%Main loop
gameLoop(GameState, Player) :- \+gameOver(GameState, Player),
                                display_game(GameState, 'B'),
                                getMove(Player, [X,Y]),
                                placePiece(GameState, Player, X, Y, NewGameState),
                                changePlayer(Player, NewPlayer),
                                gameLoop(NewGameState, NewPlayer).


%Receive input from player, and check if the move is legal.
getMove(Player, [X, Y]) :- write(Player), write(' to play.'), nl,
                            write('Where would you like to play?'), nl,
                            write('X: '),
                            read(X),
                            write('Y: '),
                            read(Y),
                            validateMove(X, Y).

getMove(Player, [X, Y]) :- write('Invalid position, choose another one.'), nl, getMove(Player, [X, Y]).



%Flip all pieces after the players move


%Check if move is legal.
validateMove(X, Y) :- X < 11, X > -1, Y < 11, Y > -11.

%Updates board with players most recent move.
placePiece([H|T], Player, X, 0, [H2|T]) :- placePiece(H, Player, X, -1, H2).
placePiece([H|T], Player, X, Y, [H|R]) :- Y > -1, Y1 is Y-1, placePiece(T, Player, X, Y1, R). 

placePiece([_|T], Player, 0, -1, [Player|T]).
placePiece([H|T], Player, X, -1, [H|R]) :- X > -1, X1 is X-1, placePiece(T, Player, X1, -1, R).


%will check if game has ended
gameOver(GameState, Player) :- 2 == 3.