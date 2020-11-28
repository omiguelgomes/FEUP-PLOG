teste:-
    omega(GameState), 
    testeGameLoop(GameState, 'B').

/*Main loop*/
testeGameLoop(GameState, Player) :- 
    display_game(GameState, Player),
    move(GameState, Player, [X,Y]),
    placePiece(GameState, Player, X, Y, NewGameState),
    /*Testarino*/
    testeflipPieces(NewGameState, Player, X, Y, UltraNewGameState, TrueFinal),
    getOpponent(Player, Opponent),
    testeGameLoop(TrueFinal, Opponent).

testeflipPieces(GameState, Player, X, Y, UltraNewGameState, TrueFinal):-
    /*checkar linha*/
    getRow(Y, GameState, Row),
    write('entrar'),
    checkRowRight(GameState, Player, X, Y, Row, [], UltraNewGameState, TrueFinal),
    
    /*Checkar coluna TODO*/
    /*Checkar diagonal TODO*/
    write('sair').

checkRowRight(GameState, Player, 9, Y, Row, TempList, GameState, GameState).

checkRowRight(GameState, Player, X, Y, Row, TempList, NewGameState, TrueFinal):-
    NewX is X+1,
    getCellInRow(NewX, Row, Value),
    (       /* Free space, can end*/ 
            Value == ' ' -> checkRowRight(GameState, Player, 9, Y, Row, TempList,NewGameState, TrueFinal)
        ;    /* Wall piece, can end */
            Value == '#' -> checkRowRight(GameState, Player, 9, Y, Row, TempList,NewGameState, TrueFinal) 
        ;   /* Player piece, flip current list, dont add */
            Value == Player ->  flipList(Player,GameState, TempList, Y, NewGameState, Final),                             
                                checkRowRight(Final, Player, 9, Y, Row, TempList,_, TrueFinal)    
        ;   /* otherwise (oponent piece append to fliplist) -> */
            append(TempList, [NewX], NewTempList),
            checkRowRight(GameState, Player, NewX, Y, Row, NewTempList,NewGameState, TrueFinal)
        ).
     
flipList(Player,GameState, [], Y, GameState, GameState).

flipList(Player,GameState, [H|Rest], Y, NewGameState, Final):-
    placePiece(GameState, Player, H, Y, NewGameState),
    flipList(Player, NewGameState, Rest, Y, _, Final).


