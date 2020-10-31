%first startGame, shows original board, and calls real startGame
startGame :- initial(GameState), display_game(GameState, 'B'), gameLoop(GameState, 'B').


gameLoop(GameState, Player) :- \+gameOver(GameState, Player),
                                getMove(Player, [X,Y]),
                                makeMove(GameState, Player, X, Y, NewGameState),
                                display_game(NewGameState, 'W'),
                                gameLoop(NewGameState, 'W').



getMove(Player, [X, Y]) :- write(Player), write(' to play.'), nl,
                            write('Where would you like to play?'), nl,
                            write('X: '), nl,
                            read(X),
                            write('Y: '),
                            read(Y),
                            validateMove(X, Y).

getMove(Player, [X, Y]) :- write('Invalid position, choose another one.'), nl, getMove(Player, [X, Y]).



validateMove(X, Y) :- X < 11, X > -1, Y < 11, Y > -11.




makeMove([H|T], Player, X, 0, [H2|T]) :- makeMove(H, Player, X, -1, H2).
makeMove([H|T], Player, X, Y, [H|R]) :- Y > -1, Y1 is Y-1, makeMove(T, Player, X, Y1, R). 

makeMove([_|T], Player, 0, -1, [Player|T]).
makeMove([H|T], Player, X, -1, [H|R]) :- X > -1, X1 is X-1, makeMove(T, Player, X1, -1, R).


%will check if game has ended
gameOver(GameState, Player) :- 2 == 3.