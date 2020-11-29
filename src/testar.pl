teste:-
    teste(GameState), 
    testeGameLoop(GameState, 'B').

/*PvP Main loop*/
testeGameLoop(GameState, Player) :- \+game_over(GameState, Player, Winner),
                                display_game(GameState, Player),
                                getMove(GameState, Player, [X, Y]),
                                move(GameState, Player, [X,Y], NewGameState),
                                getOpponent(Player, Opponent),
                                display_game(NewGameState, Opponent),
                                gameLoop(NewGameState, Opponent).

testeGameLoop(_, _).