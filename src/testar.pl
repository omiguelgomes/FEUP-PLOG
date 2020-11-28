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

testeflipPieces(GameState, Player, X, Y, UltraNewGameState, Final):-
    /*checkar linha*/
    getRow(Y, GameState, Row),
    write('entrar'),
    checkRowRight(GameState, Player, X, Y, Row, [], TempList),
    checkRowLeft(GameState, Player, X, Y, Row, [], TempList2),
    append(TempList, TempList2, NewTempList),
    flipList(Player,GameState, NewTempList, Y, NewGameState, Final),
    /*Checkar coluna TODO*/
    /*Checkar diagonal TODO*/
    write('sair').

checkRowRight(GameState, Player, 9, Y, Row, TempList, TempList).

checkRowRight(GameState, Player, X, Y, Row, TempList, FinalList):-
    NewX is X+1,
    getCellInRow(NewX, Row, Value),
    (       /* Free space, can end*/ 
            Value == ' ' -> checkRowRight(GameState, Player, 9, Y, Row, TempList,FinalList)
        ;    /* Wall piece, can end */
            Value == '#' -> checkRowRight(GameState, Player, 9, Y, Row, TempList,FinalList) 
        ;   /* Player piece, flip current list, dont add */
            Value == Player -> checkRowRight(Final, Player, 9, Y, Row, TempList, FinalList)    
        ;   /* otherwise (oponent piece append to fliplist) -> */
            append(TempList, [NewX], NewTempList),
            checkRowRight(GameState, Player, NewX, Y, Row, NewTempList, FinalList)
    ).

checkRowLeft(GameState, Player, 0, Y, Row, TempList, TempList).

checkRowLeft(GameState, Player, X, Y, Row, TempList, FinalList):-
    NewX is X-1,
    getCellInRow(NewX, Row, Value),
    (       /* Free space, can end*/ 
            Value == ' ' -> checkRowRight(GameState, Player, 0, Y, Row, TempList,FinalList)
        ;    /* Wall piece, can end */
            Value == '#' -> checkRowRight(GameState, Player, 0, Y, Row, TempList,FinalList) 
        ;   /* Player piece, flip current list, dont add */
            Value == Player ->  checkRowRight(Final, Player, 0, Y, Row, TempList, FinalList)    
        ;   /* otherwise (oponent piece append to fliplist) -> */
            append(TempList, [NewX], NewTempList),
            checkRowRight(GameState, Player, NewX, Y, Row, NewTempList, FinalList)
        ).    

     
flipList(Player,GameState, [], Y, GameState, GameState).

flipList(Player,GameState, [H|Rest], Y, NewGameState, Final):-
    placePiece(GameState, Player, H, Y, NewGameState),
    flipList(Player, NewGameState, Rest, Y, _, Final).
