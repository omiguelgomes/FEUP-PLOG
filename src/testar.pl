teste:-
    omega(GameState), 
    testeGameLoop(GameState, 'B').

/*Main loop*/
testeGameLoop(GameState, Player) :- 
    display_game(GameState, Player),
    move(GameState, Player, [X,Y]),
    placePiece(GameState, Player, X, Y, NewGameState),
    /*Testarino*/
    flipPieces(NewGameState, Player, X, Y, UltraNewGameState, TrueFinal),
    getOpponent(Player, Opponent),
    testeGameLoop(TrueFinal, Opponent).