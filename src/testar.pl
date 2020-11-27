teste:-
    omega(GameState), 
    testeGameLoop(GameState, 'B').

/*Main loop*/
testeGameLoop(GameState, Player) :- 
    display_game(GameState, Player),
    move(GameState, Player, [X,Y]),
    placePiece(GameState, Player, X, Y, NewGameState),
    /*Testarino*/
    testeflipPieces(NewGameState, Player, X, Y, UltraNewGameState),
    getOpponent(Player, Opponent),
    testeGameLoop(UltraNewGameState, Opponent).

testeflipPieces(GameState, Player, X, Y, UltraNewGameState):-
    /*checkar linha*/
    getRow(Y, GameState, Row),
    write('entrar'),
    checkRowRight(GameState, Player, X, Y, Row, [], UltraNewGameState),
    /*Checkar coluna TODO*/
    /*Checkar diagonal TODO*/
    write('sair').

checkRowRight(GameState, Player, 9, Y, Row, TempList, GameState).

checkRowRight(GameState, Player, X, Y, Row, TempList, NewGameState):-
    nl,write('x= '),write(X),nl,
    NewX is X+1,
    write('NewX= '),write(NewX),nl,
    getCellInRow(NewX, Row, Value),
    write('value= '),write(Value),nl,
    write('player= '),write(Player),nl,nl,
    (       /* Free space, can end*/ 
            Value == ' ' -> checkRowRight(GameState, Player, 9, Y, Row, TempList,NewGameState)
        ;    /* Wall piece, can end */
            Value == '#' -> checkRowRight(GameState, Player, 9, Y, Row, TempList,NewGameState) 
        ;   /* Player piece, flip current list, don't add */
            Value == Player -> write('mesmoaqui'),write('TempList: '), 
                                write(TempList), nl,flipList(Player,GameState, TempList, Y, NewGameState),
                                write('bateu'),nl,                                
                                checkRowRight(NewGameState, Player, 9, Y, Row, TempList,NewGameState)    
        ;   /* otherwise (oponent piece append to fliplist) -> */
            append(TempList, [NewX], NewTempList),
            write('TempList: '), write(TempList), nl,
            write('NewTempList: '), write(NewTempList), nl,
            checkRowRight(GameState, Player, NewX, Y, Row, NewTempList,NewGameState)
        ). 
flipList(Player,GameState, [], Y, NewGameState):-
    write('omega'),
    display_game(GameState, Player),nl, nl.

flipList(Player,GameState, [], Y, Aux):-
    write('pois e'),
    display_game(GameState, Player),nl, nl,
    flipList(Player,GameState,[],Y,GameState).

flipList(Player,GameState, [H|Rest], Y, NewGameState):-
    write('H: '), write(H), nl,
    write('lag'),
    write('Rest: '), write(Rest), nl,
    placePiece(GameState, Player, H, Y, NewGameState),
    write('lalalalalalalalal'),nl,
    flipList(Player, NewGameState, Rest, Y, _).


